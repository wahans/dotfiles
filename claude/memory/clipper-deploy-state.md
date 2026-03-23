---
name: Clipper Deploy State
description: Current deploy status, auth flow, env vars, and lessons learned for the CrossLayer Clipper performance app
type: project
domain: crosslayer
---

# Clipper (CrossLayer Performance App) - Deploy State

## Current Status
- All 5 migration phases complete and merged to main
- Repo: `wh-cl/clipper` (transferred from wahans, renamed from crosslayer-performance-app)
- Git identity for this repo: `crosley-b0t` / `crosley.bot@agentmail.to`
- Deployed to Vercel at: `https://crosslayer-clipper.vercel.app`
- Database: Supabase Postgres at `ttizoihdfdvgdgozswlw.supabase.co`

## Login: FIXED (2026-03-03)
- Root cause: Supabase direct connection (`db.*.supabase.co:5432`) resolves to IPv6 only, Vercel serverless can't reach IPv6 (`ENETUNREACH`)
- Fix: Switched DATABASE_URL to Supabase pooler (Supavisor) which has IPv4: `aws-0-us-west-2.pooler.supabase.com:6543`
- Also: Password `$zf0TE!C1j1` needs `$` URL-encoded as `%24` in the connection string
- Also: Switched `db.query.users.findFirst()` to `db.select().from()` + added error logging in authorize

## Auth Flow (src/lib/auth.ts)
1. CredentialsProvider.authorize() checks domain against ALLOWED_DOMAINS
2. Queries `db.query.users.findFirst` by email
3. Calls `verifyPassword(password, user.hashedPassword)` via bcrypt.compare
4. signIn callback does another domain check
5. JWT strategy, 8hr max session

## Key Files
- Auth: `src/lib/auth.ts` — domain allowlist `["crosslayer.com", "crosslayercap.com"]`
- DB: `src/db/index.ts` — pg pool to Supabase
- Schema: `src/db/schema.ts` — pgTable definitions
- Login page: `src/app/(auth)/login/page.tsx`
- Middleware: `src/middleware.ts` — NextAuth withAuth wrapper

## Env Vars Set in Vercel
- DATABASE_URL, NEXTAUTH_SECRET, NEXTAUTH_URL, NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, ANTHROPIC_API_KEY, CRON_SECRET
- Azure AD vars also set (AZURE_AD_CLIENT_ID, AZURE_AD_CLIENT_SECRET, AZURE_AD_TENANT_ID)

## Recovered Files (phase5-cleanup)
- Phase 5 cleanup (2026-03-03, commit `4bf0ebb`) incorrectly deleted `quarterly-data-import-q3-2025.xlsx` and import scripts alongside legitimate prototype/mockup cleanup
- Recovered files saved to `~/Desktop/phase5-recovered/` (dnu/ subfolder = legitimately removed)
- Files worth restoring to repo if needed: `quarterly-data-import-q3-2025.xlsx`, `scripts/import-positions.js`, `scripts/import-positions-fixed.js`, `scripts/import-company-totals.js`, `scripts/reconcile-data.py`, `scripts/auto-assign-managers.ts`
- Rule: Claude cleanup commits tend to sweep broadly — always review `--diff-filter=D` before merging cleanup PRs

## Lessons Learned
- Supabase direct connection is IPv6-only; Vercel serverless needs IPv4 → use pooler
- Supabase pooler region must match project region (us-west-2 for this project)
- `$` in passwords must be URL-encoded (`%24`) in DATABASE_URL
- Always add error logging in NextAuth authorize — it swallows errors silently
- Git recovery: `git show <commit>^:<path>` restores deleted files; for unicode filenames use `git ls-tree` + `git cat-file blob <hash>`
