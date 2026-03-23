---
name: Folder structure conventions
description: Target folder naming and organization for MacBook Pro and Mac Mini
type: project
domain: both
---

## MacBook Pro (`/Users/wallyhansen`)

```
~/cl/                        ← all CrossLayer work (shorter names = better)
    apps/
        clipper/             ← crosslayer-performance-app, deployed to Vercel
        crosslayer/          ← app idea
        finance-ops/         ← app idea
        library/             ← app idea
        pitch-deck/          ← app idea
        portfolio-analysis/  ← app idea
    knowledge/
        vault/               ← meetings archive
        granola-notes/       ← Granola meeting note exports
        meeting-prep/        ← liquid manager framework, prep scripts
    cl-os/                   ← CrossLayer agentic OS / monorepo
        agentic-org/         ← agent teams and structure (clea and others inside)
        integrations/
            outlook-mcp/
            slack-mcp/
            granola/
        workflows/
        apps/                ← empty after moving app ideas to ~/cl/apps/
        venv/                ← Python 3.12 env for cl-os scripts
        ...
    venv/                    ← shared Python 3.14 env (pyairtable, msal)

~/pn/    ← personal projects
    aldo/
    api-tracker/
    braindump/
    claude-sandbox/
    clawd/
    compacter/
    dexter/
    go/
    pocketco/
    spawner-skills/
    throttl/
    token-launchpad/
```

**Rule**: Always `cd` into project before running `claude`. Never run from `~`.
**Clipper repo**: `crosley-b0t/crosslayer-performance-app` on GitHub (name unchanged), deployed at `crosslayer-clipper.vercel.app`

**Why:** Isolate domains for safety when running `--dangerously-skip-permissions`. Projects scattered at `~` root expose `.secrets/`, `.ssh/`, `.outlook-mcp-tokens.json`, and CrossLayer/personal work to each other.

**How to apply:** When starting any Claude session on MBP, always `cd` into project under `~/cl/` or `~/pn/` — never run from `~`. When helping reorganize, use `cl` and `pn` as the target dir names.

## Mac Mini (`/Users/jwh`)

Similar consolidation needed. Workspaces (`crosley-workspace/`, `eva-workspace/`, `river-workspace/`) and projects (`polymarket-bot/`, `peloton-receipt-mailer/`, etc.) are scattered at `~` root.

**Pending issues:**
- `.git-credentials` at `~` root — 3 stored plaintext credentials, 210 bytes. High risk. Should migrate to SSH keys or macOS keychain.
- `.zshrc` symlink broken → `/Users/openclaw/dotfiles/.zshrc` (openclaw user doesn't exist)
- `CLAUDE.md` symlink broken → `/Users/openclaw/.claude/CLAUDE.md` (same)
- `/Users/openclaw` does not exist (was renamed to `jwh`, home dir path didn't update)
