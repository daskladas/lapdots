#!/usr/bin/env bash

declare -A APPS
APPS=(
  # Office
  ["LibreOffice"]="libreoffice"
  ["Writer"]="libreoffice --writer"
  ["Calc"]="libreoffice --calc"
  ["Impress"]="libreoffice --impress"

  # Browser
  ["Chromium"]="chromium"
  ["Brave"]="brave"

  # Creative
  ["GIMP"]="gimp"
  ["Darktable"]="darktable"
  ["OBS Studio"]="obs"
  ["Kdenlive"]="kdenlive"

  # Files
  ["Nautilus"]="nautilus"
  ["File Roller"]="file-roller"
  ["gThumb"]="gthumb"
)

if [ -n "$1" ]; then
  cmd="${APPS[$1]}"
  if [ -n "$cmd" ]; then
    eval "$cmd" &
  fi
else
  printf '%s\n' "${!APPS[@]}" | sort
fi
