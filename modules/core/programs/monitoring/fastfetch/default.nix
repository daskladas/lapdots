{ username, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ neofetch ];

  home-manager.users.${username} = _: {
    home.file = {
      ".config/neofetch/config.conf".source = ./neofetch-config.conf;
    };
  };
}
