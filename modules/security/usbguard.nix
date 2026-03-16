{ lib, config, pkgs, username, ... }:
let
  cfg = config.security.usb;
in
{
  options.security.usb = {
    enable = lib.mkEnableOption "USBGuard device whitelisting with popup notifications";
  };

  config = lib.mkIf cfg.enable {
    services.usbguard = {
      enable = true;
      implicitPolicyTarget = "block";

      IPCAllowedUsers = [ "root" "${username}" ];
      IPCAllowedGroups = [ "usbguard" ];

      rules = ''
        # Linux Foundation root hubs (internal)
        allow id 1d6b:*

        # Intel USB Hub (internal)
        allow id 8087:*

        # Lenovo Dock & internal devices
        allow id 17ef:*

        # ASUS ROG Mouse & Receiver
        allow id 0b05:*

        # VIA Labs USB Hubs (Dock)
        allow id 2109:*

        # Realtek Ethernet (Dock)
        allow id 0bda:8153

        # Synaptics Fingerprint Reader (internal)
        allow id 06cb:*

        # Foxconn Bluetooth Adapter (internal)
        allow id 0489:*

        # Bison Webcam (internal)
        allow id 5986:*
      '';
    };

    users.users.${username}.extraGroups = [ "usbguard" ];

    environment.systemPackages = with pkgs; [
      usbguard
      zenity
      (pkgs.writeShellScriptBin "usb-allow" ''
        echo "=== Blocked USB devices ==="
        ${pkgs.usbguard}/bin/usbguard list-devices -b
      '')
      (pkgs.writeShellScriptBin "usb-list" ''
        echo "=== All USB devices ==="
        ${pkgs.usbguard}/bin/usbguard list-devices
      '')
    ];

    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.usbguard.Policy1.appendRule" ||
            action.id == "org.usbguard.Policy1.removeRule" ||
            action.id == "org.usbguard.Devices1.applyDevicePolicy") {
          if (subject.isInGroup("usbguard")) {
            return polkit.Result.AUTH_ADMIN;
          }
        }
      });
    '';

    home-manager.users.${username} = {
      home.file.".local/bin/usb-popup.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          DEVICE_ID="$1"
          DEVICE_NAME="$2"

          CHOICE=$(${pkgs.zenity}/bin/zenity --question \
            --title="USB device detected" \
            --text="A new USB device was connected:\n\n<b>Name:</b> $DEVICE_NAME\n<b>ID:</b> $DEVICE_ID\n\nAllow access?" \
            --ok-label="Allow" \
            --cancel-label="Block" \
            --width=400 \
            2>/dev/null; echo $?)

          if [ "$CHOICE" = "0" ]; then
            pkexec ${pkgs.usbguard}/bin/usbguard allow-device "$DEVICE_ID"

            if [ $? -eq 0 ]; then
              ${pkgs.zenity}/bin/zenity --info \
                --title="USB allowed" \
                --text="Device allowed:\n\n$DEVICE_NAME\n\nPermission valid until unplugged." \
                --width=300 \
                2>/dev/null
            else
              ${pkgs.zenity}/bin/zenity --error \
                --title="Error" \
                --text="Authentication failed." \
                --width=300 \
                2>/dev/null
            fi
          else
            ${pkgs.zenity}/bin/zenity --warning \
              --title="USB blocked" \
              --text="Device remains blocked:\n\n$DEVICE_NAME" \
              --width=300 \
              2>/dev/null
          fi
        '';
      };

      systemd.user.services.usbguard-popup = {
        Unit = {
          Description = "USBGuard Popup Service";
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          Restart = "always";
          RestartSec = "3";
          ExecStart = "${pkgs.writeShellScript "usbguard-watch" ''
            export PATH="${pkgs.gnugrep}/bin:${pkgs.gawk}/bin:${pkgs.coreutils}/bin:$PATH"

            ${pkgs.usbguard}/bin/usbguard watch | while IFS= read -r line; do
              if echo "$line" | grep -q "target=block"; then
                sleep 0.5
                BLOCKED=$(${pkgs.usbguard}/bin/usbguard list-devices -b | tail -1)
                if [ -n "$BLOCKED" ]; then
                  DEVICE_ID=$(echo "$BLOCKED" | awk -F: '{print $1}')
                  DEVICE_NAME=$(echo "$BLOCKED" | grep -oP 'name "\K[^"]+')
                  DEVICE_VID=$(echo "$BLOCKED" | grep -oP 'id \K[0-9a-f]+:[0-9a-f]+')
                  /home/${username}/.local/bin/usb-popup.sh "$DEVICE_ID" "$DEVICE_NAME ($DEVICE_VID)"
                fi
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
