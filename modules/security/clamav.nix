{ lib, config, pkgs, username, ... }:
let
  cfg = config.security.antivirus;
in
{
  options.security.antivirus = {
    enable = lib.mkEnableOption "ClamAV antivirus with realtime download scanning";
  };

  config = lib.mkIf cfg.enable {
    services.clamav = {
      daemon.enable = true;
      updater = {
        enable = true;
        frequency = 1;
      };
    };

    environment.systemPackages = with pkgs; [
      clamav
      inotify-tools
      (pkgs.writeShellScriptBin "clamscan-status" ''
        echo "=== Last ClamAV Scan ==="
        if [ -f /var/log/clamav/scan.log ]; then
          echo ""
          echo "Date: $(stat -c %y /var/log/clamav/scan.log | cut -d'.' -f1)"
          echo ""
          INFECTED=$(grep "Infected files:" /var/log/clamav/scan.log | tail -1)
          SCANNED=$(grep "Scanned files:" /var/log/clamav/scan.log | tail -1)
          echo "$SCANNED"
          echo "$INFECTED"
          echo ""
          if grep -q "FOUND" /var/log/clamav/scan.log; then
            echo "THREATS FOUND:"
            grep "FOUND" /var/log/clamav/scan.log
          else
            echo "No threats found."
          fi
        else
          echo "No scan performed yet."
        fi
        echo ""
        echo "=== Quarantine ==="
        if [ -d "/home/${username}/.quarantine" ]; then
          COUNT=$(ls -1 "/home/${username}/.quarantine" 2>/dev/null | wc -l)
          echo "$COUNT files in quarantine"
          if [ "$COUNT" -gt 0 ]; then
            ls -la "/home/${username}/.quarantine"
          fi
        else
          echo "Quarantine folder does not exist."
        fi
      '')
      (pkgs.writeShellScriptBin "quarantine-delete" ''
        QUARANTINE_DIR="/home/${username}/.quarantine"
        if [ -d "$QUARANTINE_DIR" ]; then
          COUNT=$(ls -1 "$QUARANTINE_DIR" 2>/dev/null | wc -l)
          if [ "$COUNT" -gt 0 ]; then
            echo "The following files will be PERMANENTLY deleted:"
            ls -la "$QUARANTINE_DIR"
            echo ""
            read -p "Delete all? (yes/no): " CONFIRM
            if [ "$CONFIRM" = "yes" ]; then
              rm -rf "$QUARANTINE_DIR"/*
              echo "Quarantine emptied."
            else
              echo "Cancelled."
            fi
          else
            echo "Quarantine is already empty."
          fi
        else
          echo "Quarantine folder does not exist."
        fi
      '')
    ];

    systemd.tmpfiles.rules = [
      "d /var/log/clamav 0755 root root -"
      "f /var/log/clamav/scan.log 0644 root root -"
      "d /home/${username}/.quarantine 0700 ${username} users -"
    ];

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

          notify normal "ClamAV" "Daily scan started..."

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
            notify critical "ClamAV WARNING" "$INFECTED threats found in $SCANNED files!\n\nRun 'clamscan-status' for details."
          else
            notify normal "ClamAV scan complete" "$SCANNED files scanned.\nNo threats found."
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
      description = "Daily ClamAV Scan";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        RandomizedDelaySec = "1h";
      };
    };

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
              if [[ "$file" == *.crdownload ]] || [[ "$file" == *.part ]] || [[ "$file" == *.tmp ]]; then
                continue
              fi

              sleep 1

              if [ ! -f "$file" ]; then
                continue
              fi

              FILENAME=$(basename "$file")

              ${pkgs.libnotify}/bin/notify-send -u normal -t 0 "ClamAV Scan" "Scanning: $FILENAME\nPlease wait..."

              RESULT=$(${pkgs.clamav}/bin/clamscan --no-summary "$file" 2>&1)
              EXIT_CODE=$?

              if [ $EXIT_CODE -eq 1 ]; then
                mv "$file" "$QUARANTINE_DIR/"
                chmod 000 "$QUARANTINE_DIR/$FILENAME"
                ${pkgs.libnotify}/bin/notify-send -u critical -t 0 "VIRUS FOUND!" "File: $FILENAME\n\nFile moved to quarantine!"
              elif [ $EXIT_CODE -eq 0 ]; then
                ${pkgs.libnotify}/bin/notify-send -u normal -t 0 "File clean" "$FILENAME\n\nNo threat found."
              else
                ${pkgs.libnotify}/bin/notify-send -u normal -t 0 "Scan error" "Could not scan $FILENAME."
              fi
            done
          ''}";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
  };
}
