{ pkgs, username, ... }:
{
  # ClamAV Antivirus
  services.clamav = {
    daemon = {
      enable = true;
    };
    updater = {
      enable = true;
      frequency = 1;
    };
  };

  environment.systemPackages = with pkgs; [
    clamav
    inotify-tools
    (pkgs.writeShellScriptBin "clamscan-status" ''
      echo "=== Letzter ClamAV Scan ==="
      if [ -f /var/log/clamav/scan.log ]; then
        echo ""
        echo "📅 Datum: $(stat -c %y /var/log/clamav/scan.log | cut -d'.' -f1)"
        echo ""
        INFECTED=$(grep "Infected files:" /var/log/clamav/scan.log | tail -1)
        SCANNED=$(grep "Scanned files:" /var/log/clamav/scan.log | tail -1)
        echo "📁 $SCANNED"
        echo "🦠 $INFECTED"
        echo ""
        if grep -q "FOUND" /var/log/clamav/scan.log; then
          echo "⚠️  BEDROHUNGEN GEFUNDEN:"
          grep "FOUND" /var/log/clamav/scan.log
        else
          echo "✅ Keine Bedrohungen gefunden!"
        fi
      else
        echo "Noch kein Scan durchgeführt."
      fi
      echo ""
      echo "=== Quarantäne ==="
      if [ -d "/home/${username}/.quarantine" ]; then
        COUNT=$(ls -1 "/home/${username}/.quarantine" 2>/dev/null | wc -l)
        echo "📦 $COUNT Dateien in Quarantäne"
        if [ "$COUNT" -gt 0 ]; then
          ls -la "/home/${username}/.quarantine"
        fi
      else
        echo "Quarantäne-Ordner existiert nicht."
      fi
    '')
    (pkgs.writeShellScriptBin "quarantine-delete" ''
      QUARANTINE_DIR="/home/${username}/.quarantine"
      if [ -d "$QUARANTINE_DIR" ]; then
        COUNT=$(ls -1 "$QUARANTINE_DIR" 2>/dev/null | wc -l)
        if [ "$COUNT" -gt 0 ]; then
          echo "⚠️  Folgende Dateien werden PERMANENT gelöscht:"
          ls -la "$QUARANTINE_DIR"
          echo ""
          read -p "Wirklich alle löschen? (ja/nein): " CONFIRM
          if [ "$CONFIRM" = "ja" ]; then
            rm -rf "$QUARANTINE_DIR"/*
            echo "✅ Quarantäne geleert."
          else
            echo "Abgebrochen."
          fi
        else
          echo "Quarantäne ist bereits leer."
        fi
      else
        echo "Quarantäne-Ordner existiert nicht."
      fi
    '')
  ];

  # Ordner erstellen mit sicheren Berechtigungen
  systemd.tmpfiles.rules = [
    "d /var/log/clamav 0755 root root -"
    "f /var/log/clamav/scan.log 0644 root root -"
    "d /home/${username}/.quarantine 0700 ${username} users -"
  ];

  # Täglicher Scan - nur bei Netzbetrieb
  systemd.services.clamav-scan = {
    description = "ClamAV Virus Scan";
    path = [ pkgs.libnotify pkgs.sudo pkgs.clamav ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "clamav-scan-notify" ''
        LOG=/var/log/clamav/scan.log
        UID_USER=$(id -u ${username})
        
        notify() {
          sudo -u ${username} DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID_USER/bus \
            ${pkgs.libnotify}/bin/notify-send -u "$1" -t 0 "$2" "$3"
        }
        
        notify normal "🔍 ClamAV" "Täglicher Scan gestartet..."
        
        ${pkgs.clamav}/bin/clamscan --recursive --infected --log=$LOG \
          --exclude-dir="^/home/${username}/.cache" \
          --exclude-dir="^/home/${username}/.local/share/Steam" \
          --exclude-dir="^/home/${username}/.mozilla" \
          --exclude-dir="^/home/${username}/.config/chromium" \
          --exclude-dir="^/home/${username}/.config/VSCodium" \
          --exclude-dir="^/home/${username}/Games" \
          --exclude-dir="^/home/${username}/.nix" \
          --exclude-dir="node_modules" \
          /home/${username} \
          /tmp
        
        INFECTED=$(grep "Infected files:" $LOG | tail -1 | awk '{print $3}')
        SCANNED=$(grep "Scanned files:" $LOG | tail -1 | awk '{print $3}')
        
        if [ "$INFECTED" != "0" ]; then
          notify critical "🦠 ClamAV WARNUNG" "Es wurden $INFECTED Bedrohungen in $SCANNED Dateien gefunden!\n\nFühre 'clamscan-status' aus für Details."
        else
          notify normal "✅ ClamAV Scan abgeschlossen" "$SCANNED Dateien gescannt.\nKeine Bedrohungen gefunden."
        fi
      '';
      Nice = 19;
      IOSchedulingClass = "idle";
    };
    unitConfig = {
      ConditionACPower = "true";
    };
  };

  systemd.timers.clamav-scan = {
    description = "Täglicher ClamAV Scan";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };

  # Echtzeit-Scan für Downloads (als User-Service)
  home-manager.users.${username} = {
    systemd.user.services.clamav-realtime = {
      Unit = {
        Description = "ClamAV Realtime Download Scanner";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        Restart = "always";
        RestartSec = "5";
        ExecStart = "${pkgs.writeShellScript "clamav-realtime" ''
          DOWNLOAD_DIR="/home/${username}/Downloads"
          QUARANTINE_DIR="/home/${username}/.quarantine"
          
          mkdir -p "$QUARANTINE_DIR"
          chmod 700 "$QUARANTINE_DIR"
          
          ${pkgs.inotify-tools}/bin/inotifywait -m -r -e close_write -e moved_to "$DOWNLOAD_DIR" --format '%w%f' | while read file; do
            # Ignoriere temp-Dateien von Browsern
            if [[ "$file" == *.crdownload ]] || [[ "$file" == *.part ]] || [[ "$file" == *.tmp ]]; then
              continue
            fi
            
            sleep 1
            
            if [ ! -f "$file" ]; then
              continue
            fi
            
            FILENAME=$(basename "$file")
            
            ${pkgs.libnotify}/bin/notify-send -u normal -t 0 "🔍 ClamAV Scan" "Scanne: $FILENAME\nBitte warten..."
            
            # clamscan statt clamdscan (keine Permission-Probleme)
            RESULT=$(${pkgs.clamav}/bin/clamscan --no-summary "$file" 2>&1)
            EXIT_CODE=$?
            
            if [ $EXIT_CODE -eq 1 ]; then
              mv "$file" "$QUARANTINE_DIR/"
              chmod 000 "$QUARANTINE_DIR/$FILENAME"
              ${pkgs.libnotify}/bin/notify-send -u critical -t 0 "🦠 VIRUS GEFUNDEN!" "Datei: $FILENAME\n\nDatei wurde in Quarantäne verschoben!"
            elif [ $EXIT_CODE -eq 0 ]; then
              ${pkgs.libnotify}/bin/notify-send -u normal -t 0 "✅ Datei sauber" "$FILENAME\n\nKeine Bedrohung gefunden."
            else
              ${pkgs.libnotify}/bin/notify-send -u normal -t 0 "⚠️ Scan-Fehler" "Konnte $FILENAME nicht scannen."
            fi
          done
        ''}";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
