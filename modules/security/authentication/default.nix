{
  imports = [
    ./pam.nix
    ./ssh.nix
  ];
# NOPASSWD für wallpaper-manager
  security.sudo.extraRules = [
    {
      users = [ "daskladas" ];
      commands = [
        {
          command = "/etc/nixos/scripts/wallpaper-manager.sh";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
