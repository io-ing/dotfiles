#!/usr/bin/env bash
# 从 dotfiles 仓库还原配置到新系统
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# ── shell 配置（符号链接方式，与原机器一致）────────────────
ln -sf "$DOTFILES/bashrc"    ~/.bashrc
ln -sf "$DOTFILES/gitconfig" ~/.gitconfig
ln -sf "$DOTFILES/tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES/vimrc"     ~/.vimrc

# ── Claude Code (~/.claude) ─────────────────────────────────
mkdir -p ~/.claude/skills ~/.claude/commands

cp "$DOTFILES/claude/CLAUDE.md"     ~/.claude/CLAUDE.md
cp "$DOTFILES/claude/settings.json" ~/.claude/settings.json

rsync -a "$DOTFILES/claude/skills/"   ~/.claude/skills/
rsync -a "$DOTFILES/claude/commands/" ~/.claude/commands/

# ── Codex (~/.codex) ────────────────────────────────────────
mkdir -p ~/.codex/skills ~/.codex/rules

cp "$DOTFILES/codex/config.toml" ~/.codex/config.toml

rsync -a "$DOTFILES/codex/skills/" ~/.codex/skills/
rsync -a "$DOTFILES/codex/rules/"  ~/.codex/rules/

echo "还原完成。"
