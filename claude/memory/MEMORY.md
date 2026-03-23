# Memory

> Memory files are tagged with `domain: personal`, `domain: crosslayer`, or `domain: both`.
> Apply only memories matching the active session's domain. Shared memories apply to all sessions.

---

## Shared

### Claude Desktop (macOS)
- Sessions stored at `~/Library/Application Support/Claude/`
  - Old Cowork: `local-agent-mode-sessions/<account-id>/<org-id>/`
  - New Cowork (v1.1+): `claude-code-sessions/<account-id>/<org-id>/`
- Account ID (session dirs): `efc35d98-997a-49cb-b616-43350d568019`, Org ID: `99c07bea-f66b-4cb4-87ee-da24a1669064`
- **Always open from /Applications, never from a downloaded DMG** — DMGs trigger App Translocation (runs from read-only temp path, ignores patches to /Applications)
- If sessions missing after update: copy from `local-agent-mode-sessions/` to `claude-code-sessions/` under same account/org subdirs
- If app crashes after manual patching: re-sign with entitlements — `codesign --force --deep --sign - --entitlements <file> /Applications/Claude.app` (needs `com.apple.security.cs.allow-jit`)
- Remove quarantine bit if needed: `xattr -dr com.apple.quarantine /Applications/Claude.app`

### Devices
- **macmini**: Mac Mini at `100.105.209.23`, user `jwh`, SSH alias configured in `~/.ssh/config`
  - Transfer files: `scp ~/Downloads/FILE macmini:~/Downloads/`
  - Connect: `ssh macmini`
  - Git identity: `jwh` (previously `openclaw`, renamed)
  - Dotfiles installed at `~/dotfiles`, pull updates with `dotfiles-pull`

---

## Personal

### Dotfiles & ~/.claude Backup
- Repo: https://github.com/wahans/dotfiles at `~/dotfiles`
- Symlinked: `ssh/config` → `~/.ssh/config`, `.zshrc` → `~/.zshrc`, `.gitconfig` → `~/.gitconfig`
- **~/.claude backup**: synced to `~/dotfiles/claude/` via sync script (no dedicated repo)
- ~/.claude has local-only git for version control, but no remote — don't push
- Setup on new machine: clone repo, then `ln -s` each file
- Machine-specific config goes in `~/.zshrc.local` (sourced automatically, not tracked in repo)
- Sync: `dotfiles-push` on MacBook Pro, `dotfiles-pull` on Mac Mini

### CrossLayer Meeting Notes & Synthesis
- See [crosslayer-meeting-notes.md](crosslayer-meeting-notes.md) for the Granola → vault workflow
- Key dirs: `~/cl/knowledge/granola-notes/`, `~/cl/knowledge/vault/`, `~/cl/knowledge/meeting-prep/`

### Agent Management
- See [agent-cleanup.md](agent-cleanup.md) for patterns and guidelines

### Folder Structure & Device Organization
- See [folder-structure.md](folder-structure.md) for target layout on MBP and Mac Mini
- MBP target: `~/cl/` (CrossLayer), `~/pn/` (personal) — currently scattered at `~` root
- Mac Mini: broken symlinks to `/Users/openclaw/` (renamed to `jwh`); `.git-credentials` plaintext creds need remediation

---

## CrossLayer

### Cowork Setup
- See [cowork-setup.md](cowork-setup.md) for context files and skills built 2026-03-16

### Scheduled Jobs & LaunchD
- See [cron-launchd-setup.md](cron-launchd-setup.md) for all launchd plists, paths, and troubleshooting
- CrossLayer OS project is at `~/cl/cl-os/` — NOT `cl-os` or `Desktop/projects`

### MARA / Portfolio Reading
- See [mara-portfolio-reading-fix.md](mara-portfolio-reading-fix.md) — March 2026 auth fix + expanded capture scope
- See [mara-backlog.md](mara-backlog.md) — planned GP admin/ops channel (pending)
- Wally's preference: capture insights from ANY fund sharing content, not just portfolio whitelist
- #portfolio-reading = substantive content ONLY (letters, research, theses, commentary). NO capital calls, K-1s, AGM notices, call reminders.
- Capital calls/distributions handled by separate Power Automate flow + Slack channel
- Cron credentials in `~/.claude/scripts/mara.env` (chmod 600)
- Slack bot `claudecodebot` must be a member of #portfolio-reading (C0A6JEWM007)

### API Key in .envrc
- See [envrc-api-key-risk.md](envrc-api-key-risk.md) — Anthropic key in `~/cl/.envrc`, must move before any git init or backup of `~/cl/`

### Outlook Auth Hook
- See [outlook-auth-hook.md](outlook-auth-hook.md) — auto-starts OAuth server before authenticate tool
- **If outlook-mcp path moves**, update `~/.claude/hooks/outlook-auth-server.sh`

### Email Rule
- **ALL CrossLayer work uses Outlook only**: wally.hansen@crosslayercap.com
- No Gmail tools in any CrossLayer agent (`~/.claude/agents/`)
- Use `mcp__outlook-assistant__*` for all email operations

### Library App
- See [library-app.md](library-app.md) — may want to migrate from Tauri+React to web app
- Lives at `~/cl/apps/library-app/`

### Clipper (CrossLayer Performance App)
- See [clipper-deploy-state.md](clipper-deploy-state.md) for current deploy/debug state
- Repo: `wh-cl/clipper`, deployed at `crosslayer-clipper.vercel.app`
- Git identity for this repo: `crosley-b0t` / `crosley.bot@agentmail.to` (Vercel Hobby requires commit author = repo owner)
- DB: Supabase Postgres at `ttizoihdfdvgdgozswlw.supabase.co`
- Auth: NextAuth.js, credentials + Azure AD, domain allowlist `crosslayer.com` + `crosslayercap.com`

### GitHub Account Consolidation
- See [github-account-consolidation.md](github-account-consolidation.md) — migrating all CL repos to `wh-cl` account
- Affects: `wahans` repos, `wh-cl/clipper` (Vercel constraint)
