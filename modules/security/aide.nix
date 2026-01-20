{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    aide
    
    # Initialisiert die AIDE-Datenbank (nach jedem Rebuild ausführen!)
    (pkgs.writeShellScriptBin "aide-init" ''
      echo "🔄 Erstelle AIDE-Datenbank..."
      sudo ${pkgs.aide}/bin/aide --config=/etc/aide.conf --init
      sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db
      echo "✅ AIDE-Datenbank erstellt!"
      echo ""
      echo "ℹ️  Führe 'aide-init' nach jedem nixos-rebuild aus!"
    '')
    
    # Prüft auf Änderungen
    (pkgs.writeShellScriptBin "aide-check" ''
      echo "🔍 Prüfe Datei-Integrität..."
      sudo ${pkgs.aide}/bin/aide --config=/etc/aide.conf --check
      EXIT_CODE=$?
      if [ $EXIT_CODE -eq 0 ]; then
        echo ""
        echo "✅ Keine verdächtigen Änderungen gefunden!"
      else
        echo ""
        echo "⚠️  Änderungen erkannt! Überprüfe die Ausgabe oben."
      fi
    '')
  ];

  # AIDE Konfiguration
  environment.etc."aide.conf".text = ''
    # Datenbank-Speicherort
    database_in=file:/var/lib/aide/aide.db
    database_out=file:/var/lib/aide/aide.db.new
    
    # Was prüfen wir?
    # p = Permissions, u = User, g = Group, s = Size
    # m = Modification time, S = SHA256 hash
    NORMAL = p+u+g+s+m+S
    
    # Nur Permissions und Owner (für Ordner die sich oft ändern)
    PERMS = p+u+g
    
    # Zu überwachende Pfade
    /home/${username}/.ssh NORMAL
    /home/${username}/.gnupg NORMAL
    /home/${username}/.local/bin NORMAL
    /etc/nixos NORMAL
    /etc/passwd NORMAL
    /etc/shadow NORMAL
    /etc/group NORMAL
    /etc/sudoers NORMAL
    /etc/ssh NORMAL
    
    # Ausnahmen (ändern sich oft, ignorieren)
    !/home/${username}/.cache
    !/home/${username}/.config
    !/home/${username}/.local/share
    !/home/${username}/Downloads
    !/var/log
    !/var/cache
  '';

  # Ordner für AIDE-Datenbank erstellen
  systemd.tmpfiles.rules = [
    "d /var/lib/aide 0700 root root -"
  ];

  # Täglicher Check (optional - nur bei Netzbetrieb)
  systemd.services.aide-check = {
    description = "AIDE Integrity Check";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.aide}/bin/aide --config=/etc/aide.conf --check";
    };
    unitConfig = {
      ConditionACPower = "true";
      ConditionPathExists = "/var/lib/aide/aide.db";
    };
  };

  systemd.timers.aide-check = {
    description = "Daily AIDE Check";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };
}
