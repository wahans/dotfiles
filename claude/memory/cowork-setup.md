---
name: CrossLayer Cowork Setup
description: Files, skills, and crons built for CrossLayer Cowork context on 2026-03-16
type: project
domain: crosslayer
---

Completed CrossLayer Cowork context setup on 2026-03-16.

**Why:** Cowork sessions were starting without any innate CrossLayer context — required manual kickoff prompts for brand voice, projects, etc. CLAUDE.md auto-loads for all sessions, so context files referenced there load innately.

**Files created:**
- `~/.claude/brand-voice.md` — CrossLayer voice/tone guide derived from ~45,000 words of real writing (LP letters, investment memos, Substacks). Includes register guide (LP-facing, internal/analytical, public/social), signature phrases, rhetorical moves, and what to avoid.
- `~/.claude/current-projects.md` — living doc of active CrossLayer projects; update weekly
- `~/.claude/skills/shutdown.md` — `/shutdown` skill: checks open tasks, previews tomorrow's calendar, sets top 3 priorities

**CLAUDE.md additions (CrossLayer section):**
- Reference to both context files under CrossLayer domain
- Brand voice feedback loop rule: after any CrossLayer writing, ask for edit feedback and update brand-voice.md

**Crons added:**
- Monday 8:00am PT: opens current-projects.md for weekly update
- Monday 8:03am PT: quarterly brand voice review (first Monday of May/Aug/Nov/Feb)

**Daily brief integration:**
- `current-projects.md` is the source of truth for the daily brief's todo section — replaced `config/todo_list.py`
- `send_daily_brief.py` now parses markdown directly; items grouped by category, no due dates
- `- [ ]` = active, `- [x]` = done, `- [?]` = needs Claude interview before work begins
- `[?]` items show an amber "needs interview" badge in the brief email
- CLAUDE.md rule: when Wally references a `[?]` task, run an AskUserQuestion interview before proceeding
- Currently marked `[?]`: Portfolio Review module, pitch deck update

**How to apply:** When starting a CrossLayer Cowork session, these files load automatically via CLAUDE.md. No kickoff prompt needed beyond domain identification.
