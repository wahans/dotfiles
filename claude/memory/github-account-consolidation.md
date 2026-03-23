---
name: GitHub Account Consolidation
description: Moving all CrossLayer repos from wahans and crosley-b0t to wh-cl (wally.hansen@crosslayercap.com)
type: project
domain: crosslayer
---

All CrossLayer repos are being consolidated onto the `wh-cl` GitHub account (connected to wally.hansen@crosslayercap.com).

**Why:** Multiple accounts (wahans, wh-cl, crosley-b0t) cause auth friction — git fetches fail when the wrong account is active, and repos end up cloned to unexpected paths.

**Completed migrations:**
- `outlook-mcp`: transferred from `wahans` → `wh-cl` (2026-03-19). Submodule URL updated in cl-os.

**How to apply:**
- When creating new CrossLayer repos, use `wh-cl` as the owner
- When encountering auth issues on CrossLayer repos, check if the repo still lives under `wahans` or `crosley-b0t` and flag for migration
- Clipper repo (`wh-cl/clipper`) already on wh-cl — note the Vercel Hobby constraint requiring commit author = repo owner
