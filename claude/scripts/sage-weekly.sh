#!/bin/bash
# SAGE - Weekly Synthesis Digest
# Runs Monday 9am PT, posts weekly digest to #content-synthesis (C0ANBK97D17)
# Logs to ~/.claude/logs/sage-weekly.log

set -e

echo ""
echo "=========================================="
echo "SAGE Weekly Digest: $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo "=========================================="

export PATH="/Users/wallyhansen/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

if [ -f /Users/wallyhansen/.secrets/crosslayer-os.env ]; then
  set -a
  source /Users/wallyhansen/.secrets/crosslayer-os.env
  set +a
fi

unset ANTHROPIC_API_KEY

cd /Users/wallyhansen

/Users/wallyhansen/.local/bin/claude -p \
  --permission-mode=bypassPermissions \
  "You are SAGE, the content synthesis agent for CrossLayer Capital. Generate the weekly content synthesis digest.

## Step 1: Read the week's daily digests
Use the Slack MCP tool slack_get_channel_history to read messages from channel C0ANBK97D17 (#content-synthesis) from the last 7 days (limit 50 messages). These contain the daily digests already posted this week.

Also read messages from C0AN29SUZUL (#research-alerts) for must-read alerts posted this week.

And read messages from C0AMH8RHZBR (#sage-inbox) for any manually submitted content and synthesis replies.

## Step 2: Cross-content synthesis
Analyze all the week's content for:
- Recurring themes across multiple sources
- Emerging narratives gaining momentum
- Contrarian views or dissenting opinions
- Investment-relevant signals for a crypto fund-of-funds
- AI x Crypto developments specifically

## Step 3: Post the weekly digest
Post to Slack channel C0ANBK97D17 (#content-synthesis):

Format:
:calendar: *SAGE Weekly Digest — Week of [Date Range]*

*Executive Summary:*
[3-5 sentences synthesizing the week's most important developments and their implications for CrossLayer Capital]

---

:star: *Top Content This Week* (5-10 items max)
[Ranked by relevance. For each:]
1. *[Title]* — _[Source]_
   [1-2 sentence summary + why it matters]

---

:mag: *Emerging Narratives*
[2-4 themes or narratives that gained momentum this week, with supporting evidence from multiple sources]

---

:crystal_ball: *AI x Crypto Watch*
[Developments specifically at the intersection of AI and crypto — new projects, research, infrastructure, token launches]

---

:thinking_face: *Contrarian Corner*
[Any notable dissenting views or counter-narratives worth tracking]

---

*Week in Numbers:*
- Total items synthesized: [N]
- Must-read alerts: [N]
- Most active themes: [top 3]
- Sources with highest signal: [top 3]

---

*Recommended Deep Dives:*
[1-3 items worth loading into NotebookLM or Perplexity for further analysis]"

echo ""
echo "Completed: $(date '+%Y-%m-%d %H:%M:%S %Z')"
