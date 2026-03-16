{ lib, config, pkgs, ... }:
let
  cfg = config.security.hardening;
in
{
  options.security.hardening = {
    enable = lib.mkEnableOption "kernel hardening and auditd monitoring";
  };

  config = lib.mkIf cfg.enable {
    boot.kernel.sysctl = {
      # Network hardening
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      "net.ipv4.tcp_syncookies" = 1;

      # Kernel hardening
      "kernel.kptr_restrict" = 2;
      "kernel.dmesg_restrict" = 1;
      "kernel.perf_event_paranoid" = 3;
      "kernel.yama.ptrace_scope" = 1;
    };

    security.auditd.enable = true;
    security.audit = {
      enable = true;
      rules = [
        "-w /var/log/lastlog -p wa -k logins"
        "-w /etc/sudoers -p wa -k sudoers"
        "-w /etc/sudoers.d -p wa -k sudoers"
        "-w /etc/passwd -p wa -k passwd_changes"
        "-w /etc/shadow -p wa -k shadow_changes"
        "-w /etc/group -p wa -k group_changes"
        "-w /etc/ssh/sshd_config -p wa -k sshd_config"
        "-w /etc/systemd -p wa -k systemd_changes"
        "-w /etc/nixos -p wa -k nixos_config"
      ];
    };

    environment.systemPackages = with pkgs; [
      audit

      (pkgs.writeShellScriptBin "audit-log" ''
        echo "=== Recent audit events ==="
        sudo ausearch -ts recent 2>/dev/null | head -50
      '')

      (pkgs.writeShellScriptBin "audit-logins" ''
        echo "=== Login attempts ==="
        sudo ausearch -k logins -ts today 2>/dev/null
      '')

      (pkgs.writeShellScriptBin "audit-sudo" ''
        echo "=== Sudo usage ==="
        sudo ausearch -k sudoers -ts today 2>/dev/null
      '')
    ];
  };
}
