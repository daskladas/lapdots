{ username, ... }:
{
  # ── PAM ──
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # ── SSH Keys ──
  users.users.${username}.openssh.authorizedKeys.keys = [ ];

  # ── Sudo ──
  security.sudo.extraRules = [
    {
      users = [ username ];
      commands = [
        { command = "/etc/nixos/scripts/wallpaper-manager.sh"; options = [ "NOPASSWD" ]; }
        { command = "/run/current-system/sw/bin/killall"; options = [ "NOPASSWD" ]; }
      ];
    }
  ];
}
