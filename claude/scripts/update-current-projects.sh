#!/bin/zsh
# Weekly prompt to update current-projects.md
osascript -e 'display notification "Update your CrossLayer active projects before the week starts." with title "Weekly Projects Review" sound name "Ping"'
open /Users/wallyhansen/.claude/current-projects.md
