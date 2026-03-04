{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      tutanota-desktop
      signal-desktop
      (discord.override {
        withOpenASAR = false;
        withVencord = true;
      })
    ];
  };
}
