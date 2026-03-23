---
name: Outlook Auth Server Hook
description: Auto-start hook for Outlook OAuth server - has hardcoded path dependency on outlook-mcp location
type: reference
domain: crosslayer
---

A PreToolUse hook in `~/.claude/settings.json` auto-starts the Outlook OAuth auth server (port 3333) before `mcp__outlook-assistant__authenticate` runs.

- Hook script: `~/.claude/hooks/outlook-auth-server.sh`
- Hardcoded path: `/Users/wallyhansen/cl/cl-os/integrations/outlook-mcp/outlook-auth-server.js`
- Auth server logs: `/tmp/outlook-auth-server.log`

**If `~/cl/cl-os/integrations/outlook-mcp/` ever moves**, update the `cd` path in `~/.claude/hooks/outlook-auth-server.sh`.
