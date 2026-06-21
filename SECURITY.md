# Security Policy

## Reporting a vulnerability

If you believe you've found a security vulnerability in bctx, **please do not open a public issue**.

Email: **security@betterctx.com**

Include:
- A description of the issue
- Steps to reproduce
- Affected version (`bctx --version`)
- Your platform (OS + arch)

We aim to acknowledge reports within **48 hours** and ship a fix within **7 days** for high-severity issues.

## Scope

In scope:
- The `bctx` CLI binary
- The MCP server (stdio + HTTP/SSE transports)
- The install scripts (`install.sh`, `install.ps1`)
- The release artifact pipeline

Out of scope:
- Vulnerabilities in third-party AI agents (Claude Code, Cursor, etc.) — report to those vendors directly
- Issues requiring physical access to the user's machine
- Social engineering

## Verifying release integrity

Every release in [bctx-releases](https://github.com/better-ctx-org/bctx-releases/releases) ships with a `SHA256SUMS` file. The official install scripts verify checksums automatically. To verify manually:

```bash
shasum -a 256 -c SHA256SUMS
```

## Privacy

bctx runs **100% locally** on the free tier. No source code, prompts, completions, or telemetry leave your machine.

Cloud-tier features (Beacon+, Studio) are explicitly opt-in and clearly labeled.
