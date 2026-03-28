param(
    [string]$input='results.sarif'
)

$ErrorActionPreference='Stop'

Write-Host '=== ReleaseGuard ==='

if(!(Test-Path $input)){
    Write-Host ('Input not found: ' + $input)
    exit 1
}

$sarif=Get-Content $input -Raw | ConvertFrom-Json

$issues=@()

foreach($run in $sarif.runs){
    foreach($result in $run.results){
        $issues+=$result
    }
}

$blockSeverities=@('error','high','critical')

$block=False
foreach($i in $issues){
    $level=($i.level).ToLower()
    if($blockSeverities -contains $level){
        $block=True
    }
}

if($block){

    Write-Host ''
    Write-Host '? RELEASE BLOCKED'
    Write-Host 'Reason: High severity findings in SARIF'

    $json=($issues | ConvertTo-Json -Compress)
    $bytes=[System.Text.Encoding]::UTF8.GetBytes($json)
    $sha=[System.Security.Cryptography.SHA256]::Create()
    $root=((System.Security.Cryptography.SHA256Managed.ComputeHash($bytes)|ForEach-Object{$_.ToString('x2')}) -join '').ToUpperInvariant()

    Write-Host ('Proof: ' + $root)
    exit 1

}else{

    Write-Host ''
    Write-Host '? RELEASE ALLOWED'
    Write-Host 'No blocking findings'
    exit 0
}
