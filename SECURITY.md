# Security Policy

## Scope

This security policy covers:

- ContractKit plugin scripts
- Template smart contracts
- Build and deployment tooling

This policy does **not** cover:

- Financial losses from deployed contracts
- Issues in dependencies (OpenZeppelin, Foundry)
- User configuration errors
- Mainnet deployment outcomes

## Reporting a Vulnerability

If you discover a security vulnerability in ContractKit, please report it responsibly:

1. **Do not** open a public GitHub issue
2. Email: security@[project-domain].com (or use GitHub Security Advisories)
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

We aim to acknowledge reports within 48 hours and provide a resolution timeline within 7 days.

## What to Report

- Command injection in scripts
- Path traversal vulnerabilities
- Secret exposure risks
- Template vulnerabilities that could lead to fund loss
- Unsafe defaults

## What NOT to Report

- "Smart contracts can have bugs" (we know; that's why we have disclaimers)
- Issues requiring user misconfiguration
- Theoretical attacks without practical exploit
- Issues in upstream dependencies (report to those projects)

## Supported Versions

| Version | Supported |
|---------|-----------|
| 0.x.x   | Yes       |

## Security Practices

ContractKit follows these practices:

- **No auto-install**: Scripts check for Foundry but don't install without consent
- **No network calls**: Scripts only call the RPC endpoint you specify
- **No secret exfiltration**: Private keys stay local; nothing phones home
- **Minimal dependencies**: Fewer deps = smaller attack surface
- **Pinned versions**: OpenZeppelin contracts pinned to stable releases

## Disclaimer

ContractKit templates are **not audited**. The `/contractkit:audit-lite` command produces a risk checklist, not a security guarantee. Always get independent security review before mainnet deployment.
