#!/bin/bash
# Blocks Claude from posting to restricted Slack channels

BLOCKED_CHANNELS=("fundraising" "general" "random")

# Read tool input from stdin
INPUT=$(cat)

# Extract channel from JSON (handles both channel_id and channel params)
CHANNEL=$(echo "$INPUT" | grep -oE '"channel(_id)?"\s*:\s*"[^"]*"' | head -1 | sed 's/.*: *"//' | tr -d '"')

# Normalize: remove # prefix if present, lowercase
CHANNEL=$(echo "$CHANNEL" | sed 's/^#//' | tr '[:upper:]' '[:lower:]')

# Check against blocked list
for blocked in "${BLOCKED_CHANNELS[@]}"; do
    if [[ "$CHANNEL" == "$blocked" || "$CHANNEL" == *"$blocked"* ]]; then
        echo "BLOCKED: Cannot post to #$blocked - this channel is restricted" >&2
        exit 2
    fi
done

exit 0
