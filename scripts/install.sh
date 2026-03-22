#!/usr/bin/env bash
# Install skills to ~/.claude/skills/ via symlinks
# Usage:
#   ./scripts/install.sh           # Install all skills
#   ./scripts/install.sh x-search  # Install specific skill

set -e

SKILLS_SRC="$(cd "$(dirname "$0")/../skills" && pwd)"
SKILLS_DST="$HOME/.claude/skills"

mkdir -p "$SKILLS_DST"

install_skill() {
  local name="$1"
  local src="$SKILLS_SRC/$name"
  local dst="$SKILLS_DST/$name"

  if [ ! -d "$src" ]; then
    echo "Error: skill '$name' not found in $SKILLS_SRC"
    exit 1
  fi

  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -d "$dst" ]; then
    echo "Warning: $dst exists and is not a symlink — skipping. Remove it manually first."
    return
  fi

  ln -s "$src" "$dst"
  echo "✓ Installed: $name → $dst"
}

if [ -n "$1" ]; then
  install_skill "$1"
else
  for skill_dir in "$SKILLS_SRC"/*/; do
    skill_name="$(basename "$skill_dir")"
    install_skill "$skill_name"
  done
fi

echo "Done."
