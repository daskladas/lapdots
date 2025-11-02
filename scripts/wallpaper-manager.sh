#!/usr/bin/env bash

# Wallpaper Manager für NixOS + Hyprland
WALLPAPER_DIR="/etc/nixos/assets/wallpapers/videos"

# Banner
cat << "EOF"
 _    _       _ _  _____ _                            
| |  | |     | | |/  __ \ |                           
| |  | | __ _| | || /  \/ |__   ___   ___  ___  ___ _ __ 
| |/\| |/ _` | | || |   | '_ \ / _ \ / _ \/ __|/ _ \ '__|
\  /\  / (_| | | || \__/\ | | | (_) | (_) \__ \  __/ |   
 \/  \/ \__,_|_|_(_)____/_| |_|\___/ \___/|___/\___|_|    
                                          by daskladas
EOF

# Hauptmenü
action=$(echo -e "Select Wallpaper\nImport Video" | rofi -dmenu -i -p "Wallpaper Manager")

case "$action" in
    "Import Video")
        # Video auswählen
        new_video=$(zenity --file-selection --title="Select Video to Import" \
            --file-filter="Videos | *.mp4 *.webm *.mkv *.avi" 2>/dev/null)
        
        if [[ -z "$new_video" ]]; then
            echo "Import abgebrochen"
            exit 0
        fi
        
        # Mit sudo kopieren (braucht Passwort)
       if pkexec cp "$new_video" "$WALLPAPER_DIR/"; then
            zenity --info --text="Video importiert:\n$(basename "$new_video")" --timeout=3
        else
            zenity --error --text="Import fehlgeschlagen!"
            exit 1
        fi
        ;;
        
    "Select Wallpaper")
        # Prüfe ob Wallpaper-Verzeichnis existiert
        if [[ ! -d "$WALLPAPER_DIR" ]]; then
            zenity --error --text="Wallpaper-Verzeichnis nicht gefunden:\n$WALLPAPER_DIR"
            exit 1
        fi

        # Liste alle Videos
        videos=($(find "$WALLPAPER_DIR" -type f \( -iname "*.mp4" -o -iname "*.webm" -o -iname "*.mkv" -o -iname "*.avi" \)))

        if [[ ${#videos[@]} -eq 0 ]]; then
            zenity --error --text="Keine Videos in:\n$WALLPAPER_DIR"
            exit 1
        fi

        # Rofi Auswahl
        selected=$(printf '%s\n' "${videos[@]##*/}" | rofi -dmenu -i -p "Select Wallpaper")

        if [[ -z "$selected" ]]; then
            echo "Abgebrochen"
            exit 0
        fi

        # Finde den vollen Pfad
        selected_path=""
        for video in "${videos[@]}"; do
            if [[ "$(basename "$video")" == "$selected" ]]; then
                selected_path="$video"
                break
            fi
        done

        # Stoppe alten mpvpaper
        sudo killall mpvpaper 2>/dev/null

        # Starte neuen mpvpaper
        mpvpaper -o "no-audio loop" --layer=background '*' "$selected_path" &

        zenity --info --text="Wallpaper geändert zu:\n$selected" --timeout=2
        ;;
        
    *)
        echo "Abgebrochen"
        exit 0
        ;;
esac
