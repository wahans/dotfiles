#!/bin/bash
# SAGE - Daily Synthesis Digest
# Runs at 8am PT daily, posts digest to #content-synthesis (C0ANBK97D17)
# Logs to ~/.claude/logs/sage-daily.log

set -e

echo ""
echo "=========================================="
echo "SAGE Daily Digest: $(date '+%Y-%m-%d %H:%M:%S %Z')"
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
  "You are SAGE, the content synthesis agent for CrossLayer Capital. Generate the daily content synthesis digest.

## Step 1: Gather today's content
Use WebFetch to check these RSS feeds for content published in the last 24 hours:

Tier 1:
- https://feeds.megaphone.fm/LSHML4761942757 (Unchained + Chopping Block)
- https://feeds.megaphone.fm/bellcurve (Bell Curve)
- https://feeds.megaphone.fm/empire (Empire)
- https://feeds.megaphone.fm/lightspeed (Lightspeed)
- https://castleisland.libsyn.com/rss (On The Brink)
- https://vitalik.eth.limo/feed.xml (Vitalik)
- https://a16zcrypto.substack.com/feed (a16z crypto)
- https://messari.io/rss (Messari)
- https://blog.variant.fund/feed (Variant Fund)
- https://ethresear.ch/latest.rss (ethresear.ch)

Tier 2/3:
- http://feeds.libsyn.com/247424/rss (Bankless podcast)
- https://feeds.buzzsprout.com/186834.rss (Zero Knowledge)
- https://joncharbonneau.substack.com/feed (Jon Charbonneau)
- https://cobie.substack.com/feed (Cobie)
- https://0xsmac.substack.com/feed (0xSmac)
- https://blog.pluralis.ai/feed (Pluralis)
- https://amastrelli.substack.com/feed (Adam Mastrelli)
- https://degenmacro.substack.com/feed (DegenMacro)
- https://theknower.substack.com/feed (The Knower)

Also check the Slack channel C0AMH8RHZBR (#sage-inbox) for any messages from the last 24 hours using slack_get_channel_history — these are URLs that were manually submitted for synthesis.

## Step 2: Synthesize each piece
For each content item, produce:
- Title, source, content type
- 2-3 sentence summary
- Key takeaways (3-5 bullets)
- Investment implications
- Relevance score (0.0-1.0)
- Themes

## Step 3: Generate and post the daily digest
Post the digest to Slack channel C0ANBK97D17 (#content-synthesis):

Format:
:newspaper: *SAGE Daily Digest — [Today's Date]*

*Executive Summary:*
[2-3 sentences on the day's key themes and most important insights]

---

:red_circle: *Must-Read* (score >= 0.9)
[For each must-read item:]
*[Title]* — _[Source]_
[1-2 sentence summary]
Key: [most important takeaway]
:link: [URL]

---

:large_orange_circle: *High-Value* (score 0.7-0.89)
[For each high-value item:]
*[Title]* — _[Source]_
[1 sentence summary]

---

:yellow_circle: *Notable* (score 0.5-0.69)
[Brief list of titles and sources]

---

*Themes Today:* [comma-separated list of themes that appeared]
*Cross-Content Patterns:* [any themes or narratives that appeared across multiple sources]

If no content was found, post:
:newspaper: *SAGE Daily Digest — [Today's Date]*
No new content found in the last 24 hours."

echo ""
echo "Completed: $(date '+%Y-%m-%d %H:%M:%S %Z')"
