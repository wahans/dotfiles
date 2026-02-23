# Dotfiles sync
alias dotfiles-push='cd ~/dotfiles && git add -A && git commit -m "update dotfiles" && git push'
alias dotfiles-pull='cd ~/dotfiles && git pull'
brewi() { brew install "$@" && brew bundle dump --force --file=~/dotfiles/Brewfile && dotfiles-push }

# Backup alias
alias backup-all='d=$(date +%Y%m%d); rm -rf ~/projects-backup-$d ~/spawner-skills-backup-$d ~/personal-backup-$d 2>/dev/null; cp -a ~/projects ~/projects-backup-$d && cp -a ~/Desktop/spawner-skills ~/spawner-skills-backup-$d && cp -a ~/Desktop/personal ~/personal-backup-$d && echo "Backup complete: $d"'

# Created by `pipx` on 2026-01-17 05:48:50
export PATH="$PATH:/Users/wallyhansen/.local/bin"
alias cua='claude-usage log agent'
alias cus='claude-usage log skill'

# Load secrets from ~/.secrets/
[[ -f ~/.secrets/shell-exports.env ]] && source ~/.secrets/shell-exports.env
[[ -f ~/.secrets/clawdbot.env ]] && source ~/.secrets/clawdbot.env
[[ -n "$GOOGLE_PLACES_API_KEY" ]] && export GOOGLE_PLACES_API_KEY GEMINI_API_KEY OPENAI_API_KEY OPENAI_IMAGEGEN_API_KEY OPENAI_WHISPER_API_KEY

# Claude Code analytics dashboard
alias claude-stats='python3 ~/.claude/scripts/generate_dashboard.py -o ~/Desktop/claude-analytics.html && open ~/Desktop/claude-analytics.html'
# ANTHROPIC_API_KEY loaded from ~/.secrets/shell-exports.env

# Git worktree Claude sessions
# Usage: wt-setup <repo-path> to create worktrees, then za/zb/zc to jump in
WT_BASE="$HOME/worktrees"
alias za='cd "$WT_BASE/a" 2>/dev/null && claude || echo "No worktree at $WT_BASE/a — run wt-setup first"'
alias zb='cd "$WT_BASE/b" 2>/dev/null && claude || echo "No worktree at $WT_BASE/b — run wt-setup first"'
alias zc='cd "$WT_BASE/c" 2>/dev/null && claude || echo "No worktree at $WT_BASE/c — run wt-setup first"'

# Create worktrees for a repo: wt-setup ~/projects/myapp [branch-a] [branch-b] [branch-c]
wt-setup() {
  local repo="${1:?Usage: wt-setup <repo-path> [branch-a] [branch-b] [branch-c]}"
  local ba="${2:-main}" bb="${3:-main}" bc="${4:-main}"
  mkdir -p "$WT_BASE"
  git -C "$repo" worktree add "$WT_BASE/a" "$ba" 2>/dev/null || git -C "$repo" worktree add "$WT_BASE/a" -b "wt-a" "$ba"
  git -C "$repo" worktree add "$WT_BASE/b" "$bb" 2>/dev/null || git -C "$repo" worktree add "$WT_BASE/b" -b "wt-b" "$bb"
  git -C "$repo" worktree add "$WT_BASE/c" "$bc" 2>/dev/null || git -C "$repo" worktree add "$WT_BASE/c" -b "wt-c" "$bc"
  echo "Worktrees ready: za (a), zb (b), zc (c)"
}

# Machine-specific overrides
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Tear down worktrees: wt-clean <repo-path>
wt-clean() {
  local repo="${1:?Usage: wt-clean <repo-path>}"
  git -C "$repo" worktree remove "$WT_BASE/a" 2>/dev/null
  git -C "$repo" worktree remove "$WT_BASE/b" 2>/dev/null
  git -C "$repo" worktree remove "$WT_BASE/c" 2>/dev/null
  echo "Worktrees removed"
}
