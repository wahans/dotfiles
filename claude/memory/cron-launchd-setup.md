---
name: Cron and LaunchD Setup
description: Cron job history, path fixes, and launchd migration for CrossLayer scheduled tasks
type: project
domain: crosslayer
---

**Project path change (2026-03-16):** CrossLayer OS project moved from `Desktop/projects/cl-os/` → `~/cl/cl-os/`. All scripts and plists must use `cl-os`, not `cl-os`.

**LaunchD migration (2026-03-16):** All scheduled jobs migrated from crontab to launchd plists. LaunchD fires missed jobs after Mac wakes from sleep; cron silently skips them. Only `claude-usage` weekly report remains in crontab.

**Active launchd plists** (`~/Library/LaunchAgents/com.wallyhansen.*.plist`):
- `dailybrief` — Mon-Fri 8am → `~/cl/cl-os/.../run_daily_brief.sh`
- `mara` — 7pm daily → `~/.claude/scripts/mara-cron.sh`
- `autoacceptinvites` — 8am/12pm/4pm/8pm daily → `~/cl/cl-os/.../run_auto_accept.sh`
- `autoacceptsummary` — 3pm daily → `~/cl/cl-os/.../run_auto_accept_summary.sh`
- `currentprojects` — Monday 8am → `~/.claude/scripts/update-current-projects.sh`
- `brandvoice` — Monday 8:03am (quarterly filter in script) → `~/.claude/scripts/brand-voice-review.sh`
- `followup-cron` — pre-existing, don't touch

**Daily brief fix (2026-03-16):** `run_daily_brief.sh` had hardcoded `BASE_DIR` pointing to `cl-os` (wrong). Fixed to `cl-os`. Brief was NOT running automatically before this fix.

**How to apply:** If a job stops running: `launchctl list | grep wallyhansen` to check status. Reload: `launchctl unload ~/Library/LaunchAgents/com.wallyhansen.[name].plist && launchctl load ~/Library/LaunchAgents/com.wallyhansen.[name].plist`
