#!/bin/zsh
# Brand voice review — runs every Monday but only fires on the first Monday
# of every third month (May, Aug, Nov, Feb cycle starting May 2026)

MONTH=$(date +%-m)
DAY=$(date +%-d)

# First Monday = day 1-7
if (( DAY > 7 )); then
  exit 0
fi

# Cycle months: 2 (Feb), 5 (May), 8 (Aug), 11 (Nov)
case $MONTH in
  2|5|8|11) ;;
  *) exit 0 ;;
esac

osascript -e 'display notification "Open ~/.claude/brand-voice.md — add any new writing samples or rules from the past quarter." with title "Quarterly Brand Voice Review" sound name "Ping"'
open /Users/wallyhansen/.claude/brand-voice.md
