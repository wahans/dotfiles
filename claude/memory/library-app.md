---
name: Library app - potential Tauri to webapp migration
description: Note to consider converting library-app from Tauri+React to a web app
type: project
domain: crosslayer
---

`~/cl/apps/library-app/` is currently a Tauri + React desktop app.

Wally may want to convert it to a web app (similar to how crosslayer-performance-app/Clipper was migrated from Tauri to a Next.js web dashboard).

**Why:** Web app = easier team access, no install required, same pattern as Clipper migration.

**How to apply:** When working on library-app, flag this consideration. If starting new feature work, suggest evaluating the migration first.
