#!/usr/bin/env bash
set -e

shopt -s nullglob

src="$HOME/.claude/skills"

for dir in "$src"/*/; do
  name="$(basename "$dir")"
  rm -rf "./$name"
  cp -a "$dir" "./$name"
done

echo "Synced skills from: $src -> $(pwd)"
