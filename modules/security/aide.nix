{ lib, config, pkgs, username, ... }:
let
  cfg = config.security.integrity;
in
{
  options.security.integrity = {
    enable = lib.mkEnableOption "AIDE file integrity monitoring";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      aide

      (pkgs.writeShellScriptBin "aide-init" ''
        echo "Creating AIDE database..."
        sudo ${pkgs.aide}/bin/aide --config=/etc/aide.conf --init
        sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db
        echo "AIDE database created!"
        echo ""
        echo "Run 'aide-init' after every nixos-rebuild!"
      '')

      (pkgs.writeShellScriptBin "aide-check" ''
        echo "Checking file integrity..."
        sudo ${pkgs.aide}/bin/aide --config=/etc/aide.conf --check
        EXIT_CODE=$?
        if [ $EXIT_CODE -eq 0 ]; then
          echo ""
          echo "No suspicious changes found."
        else
          echo ""
          echo "Changes detected! Review the output above."
        fi
      '')
    ];

    environment.etc."aide.conf".text = ''
      database_in=file:/var/lib/aide/aide.db
      database_out=file:/var/lib/aide/aide.db.new

      NORMAL = p+u+g+s+m+S
      PERMS = p+u+g

      /home/${username}/.ssh NORMAL
      /home/${username}/.gnupg NORMAL
      /home/${username}/.local/bin NORMAL
      /etc/nixos NORMAL
      /etc/passwd NORMAL
      /etc/shadow NORMAL
      /etc/group NORMAL
      /etc/sudoers NORMAL
      /etc/ssh NORMAL

      !/home/${username}/.cache
      !/home/${username}/.config
      !/home/${username}/.local/share
      !/home/${username}/Downloads
      !/var/log
      !/var/cache
    '';

    systemd.tmpfiles.rules = [
      "d /var/lib/aide 0700 root root -"
    ];

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
  };
}
