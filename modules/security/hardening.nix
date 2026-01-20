{ pkgs, ... }:
{
  # ===== Kernel Hardening Settings =====
  boot.kernel.sysctl = {
    # --- Netzwerk-Hardening ---
    # Überprüft ob eingehende Pakete von gültiger Quelle kommen (Anti-Spoofing)
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    
    # Ignoriert ICMP Redirects (verhindert Man-in-the-Middle Angriffe)
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    
    # Sendet keine ICMP Redirects (nur Router sollten das tun)
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    
    # Ignoriert gefälschte ICMP Fehlermeldungen
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    
    # Schützt vor SYN-Flood DDoS Angriffen
    "net.ipv4.tcp_syncookies" = 1;
    
    # --- Kernel Hardening ---
    # Versteckt Kernel-Speicheradressen (erschwert Exploits)
    "kernel.kptr_restrict" = 2;
    
    # Nur root kann Kernel-Logs lesen (verhindert Info-Leaks)
    "kernel.dmesg_restrict" = 1;
    
    # Schränkt Performance-Monitoring ein (verhindert Seitenkanal-Angriffe)
    "kernel.perf_event_paranoid" = 3;
    
    # Verhindert dass Programme andere Programme debuggen/ausspionieren
    "kernel.yama.ptrace_scope" = 1;
  };

  # ===== Auditd - System-Überwachung =====
  # Loggt sicherheitsrelevante Ereignisse
  security.auditd.enable = true;
  security.audit = {
    enable = true;
    rules = [
      # Überwacht Login-Versuche
      "-w /var/log/lastlog -p wa -k logins"
      
      # Überwacht Änderungen an sudo-Regeln
      "-w /etc/sudoers -p wa -k sudoers"
      "-w /etc/sudoers.d -p wa -k sudoers"
      
      # Überwacht Änderungen an Benutzer/Passwort-Dateien
      "-w /etc/passwd -p wa -k passwd_changes"    # Benutzerkonten
      "-w /etc/shadow -p wa -k shadow_changes"    # Passwort-Hashes
      "-w /etc/group -p wa -k group_changes"      # Gruppen
      
      # Überwacht SSH-Konfiguration
      "-w /etc/ssh/sshd_config -p wa -k sshd_config"
      
      # Überwacht Systemd-Service-Änderungen
      "-w /etc/systemd -p wa -k systemd_changes"
      
      # Überwacht NixOS-Konfiguration
      "-w /etc/nixos -p wa -k nixos_config"
    ];
  };

  # ===== Audit-Tools =====
  environment.systemPackages = with pkgs; [
    audit
    
    # Zeigt letzte Security-Events
    (pkgs.writeShellScriptBin "audit-log" ''
      echo "=== Letzte Audit-Events ==="
      sudo ausearch -ts recent 2>/dev/null | head -50
    '')
    
    # Zeigt Login-Versuche von heute
    (pkgs.writeShellScriptBin "audit-logins" ''
      echo "=== Login-Versuche ==="
      sudo ausearch -k logins -ts today 2>/dev/null
    '')
    
    # Zeigt Sudo-Nutzung von heute
    (pkgs.writeShellScriptBin "audit-sudo" ''
      echo "=== Sudo-Nutzung ==="
      sudo ausearch -k sudoers -ts today 2>/dev/null
    '')
  ];
}
