# ReleaseGuard — Blocks insecure releases automatically

Add one step to your CI → your pipeline stops if insecure code is detected.

Works with SARIF (CodeQL, Semgrep, and other security tools).

---

## What it does

- Reads SARIF security results  
- Detects high/critical issues  
- Blocks the release automatically  
- Generates a cryptographic proof (SHA256)  

---

## Quick Use

- name: ReleaseGuard  
  uses: 88nonog-dev/releaseguard@v1  
  with:  
    sarif: results.sarif  

---

## Example Output

RELEASE BLOCKED  
Reason: High severity findings in SARIF  
Proof: SHA256_HASH  

---

## Why it matters

Security tools detect issues.  
ReleaseGuard enforces decisions.

Instead of "we saw a problem" →  
You get: "the release was stopped automatically".

---

## How it works

1. Your security tool generates SARIF  
2. ReleaseGuard reads the results  
3. If high severity is found:  
   - The pipeline fails  
   - A proof is generated  

---

## Status

Working demo + CI integration ready

---

## Enterprise Version (Private)

ReleaseGuard also supports advanced capabilities:

- Multi-signature approval  
- Append-only audit ledger  
- Merkle-based verification  
- Replayable decision proof  
- Policy enforcement at scale  

For enterprise use, contact directly.

---

## Summary

ReleaseGuard turns security findings into enforced decisions.
