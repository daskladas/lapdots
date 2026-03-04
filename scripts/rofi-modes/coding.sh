#!/usr/bin/env bash

declare -A APPS
APPS=(
  ["Neovim"]="kitty -e nvim"
  ["VSCodium"]="codium"
  ["Kitty"]="kitty"
  ["GitKraken"]="gitkraken"
  ["GitHub CLI"]="kitty -e gh --help"
  ["Node.js"]="kitty -e node"
  ["Python"]="kitty -e python3"
  ["Docker"]="kitty -e docker --help"
  ["Virt-Manager"]="virt-manager"
  ["Nix REPL"]="kitty -e nix repl"
)

if [ -n "$1" ]; then
  cmd="${APPS[$1]}"
  if [ -n "$cmd" ]; then
    eval "$cmd" &
  fi
else
  printf '%s\n' "${!APPS[@]}" | sort
fi
