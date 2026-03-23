#!/bin/bash
# Follow-up Drafter Cron Job
# Runs at 7am and 7pm PT to process Airtable reminder emails
# Logs to ~/.claude/logs/followup.log

set -e

# Timestamp
echo ""
echo "=========================================="
echo "Follow-up Drafter Run: $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo "=========================================="

# Set PATH to include common locations
export PATH="/Users/wallyhansen/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

# Use logged-in Claude account instead of any API key in the shell env
unset ANTHROPIC_API_KEY

# Change to home directory
cd /Users/wallyhansen

# Run Claude in non-interactive mode to process follow-ups
# Using --permission-mode=bypassPermissions since this is automated
/Users/wallyhansen/.local/bin/claude -p \
  --permission-mode=bypassPermissions \
  "Process all unread emails in my Outlook 'airtable-reminders' folder using the /airtablereminders skill. For each reminder, search Airtable for the org, pull context, draft a follow-up email, post to Slack, and mark as processed. If Outlook auth is not working, just report that and exit."

echo ""
echo "Completed: $(date '+%Y-%m-%d %H:%M:%S %Z')"
