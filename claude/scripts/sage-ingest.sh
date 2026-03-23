#!/bin/bash
# SAGE - Content Ingest Cron Job
# Runs every 6 hours to fetch and synthesize content from RSS sources
# Posts must-read alerts to #research-alerts (C0AN29SUZUL)
# Logs to ~/.claude/logs/sage-ingest.log

set -e

echo ""
echo "=========================================="
echo "SAGE Ingest: $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo "=========================================="

export PATH="/Users/wallyhansen/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

# Load env (SLACK_BOT_TOKEN, etc.)
if [ -f /Users/wallyhansen/.secrets/crosslayer-os.env ]; then
  set -a
  source /Users/wallyhansen/.secrets/crosslayer-os.env
  set +a
fi

unset ANTHROPIC_API_KEY

cd /Users/wallyhansen

/Users/wallyhansen/.local/bin/claude -p \
  --permission-mode=bypassPermissions \
  "You are SAGE, the content synthesis agent for CrossLayer Capital. Run a scheduled content ingest.

Your task: Fetch new content from SAGE's RSS sources, synthesize key takeaways, and post must-read alerts.

## Step 1: Fetch RSS content
Use the WebFetch tool to check these RSS feeds for new content published in the last 6 hours:

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

For each feed, look at items published in the last 6 hours. Skip feeds with no new items.

## Step 2: Synthesize
For each new content item found, produce:
- Title and source
- 2-3 sentence summary
- Key takeaways (3-5 bullets)
- Investment implications (1-2 sentences)
- Relevance score (0.0-1.0) based on: investment relevance to a crypto fund-of-funds, novelty of insight, quality of analysis
- Themes: tag with relevant themes (defi, infrastructure, ai_crypto, macro, regulatory, rwa, venture, governance)

## Step 3: Alert on must-reads
For any item with relevance score >= 0.9, post to Slack channel C0AN29SUZUL (#research-alerts) using the slack_post_message tool:

Format:
:brain: *MUST READ - Content Synthesis*

*[Title]*
_[Source name] ([content type])_

[2-3 sentence summary]

*Key Takeaways:*
  - [takeaway 1]
  - [takeaway 2]
  - [takeaway 3]

:dart: *Investment Implications:* [implications]

:link: [URL if available]

## Step 4: Post summary to #content-synthesis
After processing all feeds, post a brief summary to Slack channel C0ANBK97D17 (#content-synthesis):

:satellite: *SAGE Ingest Complete* — [timestamp]
Checked [N] feeds, found [N] new items
Must-read: [N] | High-value: [N] | Standard: [N]
[List must-read titles if any]

If no new content was found across all feeds, post:
:satellite: *SAGE Ingest Complete* — [timestamp]
No new content found across [N] feeds.

Do NOT skip any feeds. Check all of them."

echo ""
echo "Completed: $(date '+%Y-%m-%d %H:%M:%S %Z')"
