#!/usr/bin/env bash

declare -A APPS
APPS=(
  ["Discord"]="discord"
  ["Signal"]="signal-desktop"
  ["Teams"]="teams-for-linux"
  ["LocalSend"]="localsend"
)

if [ -n "$1" ]; then
  cmd="${APPS[$1]}"
  if [ -n "$cmd" ]; then
    eval "$cmd" &
  fi
else
  printf '%s\n' "${!APPS[@]}" | sort
fi
