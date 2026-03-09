#!/usr/bin/env bash
# 将系统配置文件同步到 dotfiles 仓库（备份方向）
# bashrc/gitconfig/tmux.conf/vimrc 已是符号链接，无需同步
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# ── Claude Code (~/.claude) ─────────────────────────────────
cp ~/.claude/CLAUDE.md      "$DOTFILES/claude/CLAUDE.md"
cp ~/.claude/settings.json  "$DOTFILES/claude/settings.json"

rsync -a --delete ~/.claude/skills/   "$DOTFILES/claude/skills/"
rsync -a --delete ~/.claude/commands/ "$DOTFILES/claude/commands/"

# ── Codex (~/.codex) ────────────────────────────────────────
cp ~/.codex/config.toml     "$DOTFILES/codex/config.toml"

rsync -a --delete ~/.codex/skills/    "$DOTFILES/codex/skills/"
rsync -a --delete ~/.codex/rules/     "$DOTFILES/codex/rules/"

echo "同步完成。接下来："
echo "  cd $DOTFILES && git add -A && git commit -m 'chore: sync configs' && git push"
