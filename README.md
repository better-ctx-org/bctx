<div align="center">

# bctx

**The context engine for AI coding agents.**

90% token reduction · 100% local processing · 17 languages · 41 skills

[![Website](https://img.shields.io/badge/website-betterctx.com-00d4ff?style=flat-square)](https://betterctx.com)
[![Docs](https://img.shields.io/badge/docs-read-blue?style=flat-square)](https://betterctx.com/docs/getting-started)
[![License](https://img.shields.io/badge/license-Apache%202.0-green?style=flat-square)](./LICENSE)
[![Releases](https://img.shields.io/github/v/release/better-ctx-org/bctx-releases?style=flat-square&label=latest)](https://github.com/better-ctx-org/bctx-releases/releases)

[Install](#install) · [How it works](#how-it-works) · [Docs](https://betterctx.com/docs/getting-started) · [Benchmark](https://betterctx.com/benchmark)

</div>

---

## What is bctx?

`bctx` is a local-first CLI and MCP server that slashes the token cost of your AI coding agent (Claude Code, Cursor, Windsurf, Codex, Gemini, and 20+ others) by compressing what the agent reads — without losing the information the agent actually needs.

- **90% fewer tokens** on real codebases (see the [benchmark](https://betterctx.com/benchmark))
- **100% local** — your code never leaves your machine
- **41 skills** for reading, analysis, execution, memory, and session control
- **24 native integrations** + works with any MCP-compatible agent
- **17 languages** — Rust, TypeScript, Python, Go, Java, Swift, C/C++, Ruby, PHP, and more

## Install

**macOS / Linux**
```bash
curl -fsSL https://betterctx.com/install.sh | sh
```

**Windows (PowerShell)**
```powershell
irm https://betterctx.com/install.ps1 | iex
```

**Homebrew**
```bash
brew tap better-ctx-org/bctx && brew install bctx
```

**npm**
```bash
npm install -g bctx-bin
```

Then:
```bash
bctx init        # auto-configure for installed agents
bctx doctor      # verify the install
bctx --version
```

## How it works

```text
your agent  →  MCP request  →  bctx (local)  →  compressed context  →  agent
                                    │
                                    ├─ tree-sitter parsing (17 langs)
                                    ├─ 41 skills (sieve, cartograph, chisel, …)
                                    └─ semantic compression
```

Instead of dumping entire files into your agent's context window, bctx returns only the symbols, signatures, and structural information the agent needs to answer the current question. Full source is fetched on demand.

Read the full architecture: <https://betterctx.com/how-it-works>

## Features

| | |
|---|---|
| **Local-first** | Runs entirely on your machine. No code, prompts, or telemetry leave your laptop on the free tier. |
| **41 skills** | Sieve, Cartograph, Chisel, Sediment, Prism, Compass, Condenser, Archivist, Scout, Chronicler, Alchemist, Sentinel, and 29 more. |
| **MCP-native** | stdio + HTTP/SSE transports. Works with any MCP-compatible agent. |
| **17 languages** | Rust · TypeScript · JavaScript · Python · Go · Java · Kotlin · Scala · Dart · Swift · Elixir · C · C++ · Ruby · PHP · Zig · Bash |
| **Bypass when you need to** | `BCTX_BYPASS=1` or drop a `.bctx-bypass` file in the repo root. |
| **Observable** | Built-in analytics show exactly what tokens you saved, per session. |

## Pricing

- **Free** — full local CLI + MCP server. Forever.
- **Beacon+** ($9/mo) — cloud sync, cross-device sessions, team analytics.
- **Studio** ($29/mo, or $79 for 5 seats) — team features, priority support.
- **Enterprise** — custom contracts. [Contact us](https://betterctx.com/contact).

## Documentation

Full docs live at **<https://betterctx.com/docs/getting-started>**.

- [Quick reference](https://betterctx.com/docs/quick-reference)
- [Configuration](https://betterctx.com/docs/configuration)
- [CLI reference](https://betterctx.com/docs/cli)
- [Skills (MCP)](https://betterctx.com/docs/tools)
- [Security model](https://betterctx.com/docs/security-model)
- [Troubleshooting](https://betterctx.com/docs/troubleshooting)

## Releases & binaries

Pre-built signed binaries for macOS (Intel + Apple Silicon), Linux (x86_64 + aarch64, glibc + musl), and Windows live in the [bctx-releases](https://github.com/better-ctx-org/bctx-releases) repo. Each release ships with `SHA256SUMS` for verification.

## Issues & feedback

- 🐛 **Bug?** [Open an issue](https://github.com/better-ctx-org/bctx/issues/new?template=bug_report.yml)
- 💡 **Feature request?** [Open an issue](https://github.com/better-ctx-org/bctx/issues/new?template=feature_request.yml)
- 🔒 **Security issue?** See [SECURITY.md](./SECURITY.md)
- 💬 **General questions?** [Contact us](https://betterctx.com/contact)

## License

The install scripts and tooling in this repo are [Apache 2.0](./LICENSE).
The bctx binary itself is source-available commercial software — free to use under the terms displayed on first run.

---

<div align="center">

Built by humans who got tired of burning $40/day on context tokens.

[betterctx.com](https://betterctx.com)

</div>
