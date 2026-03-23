---
name: Agent Cleanup Patterns
description: Guidelines for auditing, deduplicating, and pruning Claude agent files
type: feedback
domain: personal
---

# Agent Cleanup Patterns

## 2026-02-16 Cleanup Session
Reduced from ~300 agents (~16.5K description tokens) to ~205 agents (~8.5K tokens). Efficiency threshold is 15K tokens.

## Duplicate Detection Patterns
1. **Same-domain agents with different names**: e.g. `typescript-pro` vs `typescript-agent`, `database-admin` vs `database-administrator` vs `database-agent`
2. **General + specialist overlap**: e.g. `frontend-developer` makes `react-specialist` and `nextjs-developer` redundant
3. **Agent + orchestration workflow**: e.g. `legacy-modernizer` (agent) + `legacy-modernize` (workflow that calls it) - keep the agent
4. **Reference docs masquerading as agents**: No YAML frontmatter, just markdown reference material (e.g. `deployment-spec`, `rest-best-practices`, `rbac-patterns`). Trash these.

## What to Keep vs Trash
- **Keep**: The agent with better YAML frontmatter, proactive trigger description, model specification, and broader coverage
- **Trash**: Narrow specialists when a broader agent covers the same domain
- **Trash**: Generic/vague agents (e.g. `ai-assistant`) when a specific one exists (e.g. `ai-engineer`)
- **Trash**: Orchestration workflows unless actively used - they add token cost and rarely get invoked

## Categories Wally Doesn't Use
- .NET / C# / Java / Kotlin / Spring Boot / Dapper / EF Core
- PHP / Laravel / WordPress
- Ruby / Rails
- Scala / Julia / Haskell / Elixir
- C / C++ / POSIX shell
- Rust / Go (trashed but could reinstall)
- Flutter / Unity / Minecraft
- PowerShell (all 5 variants) / Windows infra / AD security / M365 admin
- ARM Cortex / embedded systems / firmware
- Angular / Vue

## Merge Strategy
When merging two agents: read both fully, keep the file with the better structure, merge unique content from the other, then trash the weaker one.

## Prevention
Before installing new agents, check if an existing agent already covers that domain. Prefer improving an existing agent over adding a new one.
