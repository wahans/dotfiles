#!/bin/bash
# Sync valuable ~/.claude config to dotfiles for version control
# Excludes secrets (.env files, tokens, credentials)
# Run manually after changes

set -e

DEST="$HOME/dotfiles/claude"

echo "Syncing ~/.claude config to $DEST..."

# Scripts (exclude .env files)
rsync -a --exclude='*.env' ~/.claude/scripts/ "$DEST/scripts/"

# Hooks
rsync -a ~/.claude/hooks/ "$DEST/hooks/"

# Memory files
rsync -a ~/.claude/projects/-Users-wallyhansen/memory/ "$DEST/memory/"

echo "Done. Review changes with: cd $DEST && git diff"
