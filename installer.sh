#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
backup_dir="${config_dir}.backup.$(date +%Y%m%d%H%M%S)"

if ! command -v nvim >/dev/null 2>&1; then
  echo "Neovim is not installed or is not on PATH."
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "Git is not installed or is not on PATH."
  exit 1
fi

mkdir -p "$(dirname "$config_dir")"

if [ -L "$config_dir" ]; then
  current_target=$(readlink "$config_dir")
  if [ "$current_target" = "$repo_dir" ]; then
    echo "$config_dir already points to this repository."
    exit 0
  fi
  mv "$config_dir" "$backup_dir"
  echo "Moved existing symlink to $backup_dir"
elif [ -e "$config_dir" ]; then
  mv "$config_dir" "$backup_dir"
  echo "Moved existing config to $backup_dir"
fi

ln -s "$repo_dir" "$config_dir"
echo "Linked $repo_dir -> $config_dir"

echo "Start Neovim and run :Lazy sync if plugins do not install automatically."
