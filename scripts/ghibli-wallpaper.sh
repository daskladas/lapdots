#!/usr/bin/env bash

WALLPAPER_DIR="/home/daskladas/Documents/walls/ghibli-studio"
INTERVAL=300  # 5 Minuten

# Warte kurz bis swww-daemon bereit ist
sleep 2

while true; do
  find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf | while read -r img; do
    swww img "$img" \
      --transition-type fade \
      --transition-duration 3 \
      --transition-fps 60
    sleep $INTERVAL
  done
done
