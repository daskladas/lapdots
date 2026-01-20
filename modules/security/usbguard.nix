{ pkgs, username, ... }:
{
  services.usbguard = {
    enable = true;
    implicitPolicyTarget = "block";
    
    # IPC-Zugriff erlauben
    IPCAllowedUsers = [ "root" "${username}" ];
    IPCAllowedGroups = [ "usbguard" ];
    
    rules = ''
      # Linux Foundation root hubs (intern)
      allow id 1d6b:*
      
      # Intel USB Hub (intern)
      allow id 8087:*
      
      # Lenovo Dock & interne Geräte
      allow id 17ef:*
      
      # ASUS ROG Maus & Receiver
      allow id 0b05:*
      
      # VIA Labs USB Hubs (Dock)
      allow id 2109:*
      
      # Realtek Ethernet (Dock)
      allow id 0bda:8153
      
      # Synaptics Fingerprint Reader (intern)
      allow id 06cb:*
      
      # Foxconn Bluetooth Adapter (intern)
      allow id 0489:*
      
      # Bison Webcam (intern)
      allow id 5986:*
    '';
  };

  users.users.${username}.extraGroups = [ "usbguard" ];

  environment.systemPackages = with pkgs; [
    usbguard
    zenity
    (pkgs.writeShellScriptBin "usb-allow" ''
      echo "=== Blockierte USB-Geräte ==="
      ${pkgs.usbguard}/bin/usbguard list-devices -b
    '')
    (pkgs.writeShellScriptBin "usb-list" ''
      echo "=== Alle USB-Geräte ==="
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
          --title="🔌 USB-Gerät erkannt" \
          --text="Ein neues USB-Gerät wurde eingesteckt:\n\n<b>Name:</b> $DEVICE_NAME\n<b>ID:</b> $DEVICE_ID\n\nZugriff erlauben?" \
          --ok-label="✅ Ja, erlauben" \
          --cancel-label="❌ Nein, blockieren" \
          --width=400 \
          2>/dev/null; echo $?)
        
        if [ "$CHOICE" = "0" ]; then
          pkexec ${pkgs.usbguard}/bin/usbguard allow-device "$DEVICE_ID"
          
          if [ $? -eq 0 ]; then
            ${pkgs.zenity}/bin/zenity --info \
              --title="✅ USB erlaubt" \
              --text="Gerät wurde erlaubt:\n\n$DEVICE_NAME\n\n⚠️ Erlaubnis gilt bis zum Abstecken." \
              --width=300 \
              2>/dev/null
          else
            ${pkgs.zenity}/bin/zenity --error \
              --title="❌ Fehler" \
              --text="Authentifizierung fehlgeschlagen." \
              --width=300 \
              2>/dev/null
          fi
        else
          ${pkgs.zenity}/bin/zenity --warning \
            --title="🚫 USB blockiert" \
            --text="Gerät bleibt blockiert:\n\n$DEVICE_NAME" \
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
}
