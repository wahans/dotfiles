---
name: MARA portfolio-reading setup (March 2026)
description: Full history of MARA cron fixes, capture rules, and Slack format for #portfolio-reading channel
type: project
domain: crosslayer
---

## Auth fixes (two separate issues)

1. **Launchd env vars (fixed 3/19):** MARA was dead 3/11-3/19 because launchd doesn't inherit shell env vars. Fixed by sourcing `~/.claude/scripts/mara.env` (chmod 600) in cron script.

2. **Token refresh env var mismatch (fixed 3/19):** `token-storage.js` in outlook-mcp read `MS_CLIENT_ID`/`MS_CLIENT_SECRET` but the MCP config passes `OUTLOOK_CLIENT_ID`/`OUTLOOK_CLIENT_SECRET`. Initial auth worked (via `outlook-auth-server.js` which uses `config.js` with correct var names), but token refresh failed silently. Fixed by adding fallback: `process.env.MS_CLIENT_ID || process.env.OUTLOOK_CLIENT_ID`. Committed as `d8db9d4` in outlook-mcp repo.

3. **Slack bot access (fixed 3/19):** `claudecodebot` (U0AAAKZV1FB) must be a member of #portfolio-reading (C0A6JEWM007) or posts fail with `channel_not_found`.

## Capture rules

**INCLUDE:** Quarterly/monthly letters, investor letters, market updates/commentary, thematic research, deep dives, investment theses, substantive essays from fund managers/crypto investors.

**EXCLUDE:** Capital calls, distribution notices (separate Power Automate flow + Slack channel), K-1s/tax docs, AGM registration, call reminders, meeting invites, MFN elections, sales pitches.

## Slack message format

Each post starts with a report-type emoji + divider line for visual separation:
- :bar_chart: Quarterly/Monthly Report | :envelope: Investor Letter | :globe_with_meridians: Market Update | :microscope: Thematic/Research | :bulb: Investment Memo/Thesis | :bookmark: Other

Includes: subject line, document attachment/link, Outlook source email link, 3-5 bullet summary.

## Sender list maintenance

When adding new funds to Airtable pipeline, also add to the sender list in `~/.claude/scripts/mara-cron.sh`. Content-match heuristic should catch most gaps automatically, but explicit sender names improve reliability. Current list includes ~32 firms + domains.

**How to apply:** If MARA stops posting, check in order: (1) `launchctl list | grep mara` for job status, (2) `~/.claude/logs/mara.log` for errors, (3) token expiry at `~/.outlook-mcp-tokens.json`, (4) bot membership in channel.
