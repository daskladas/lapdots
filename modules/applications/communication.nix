{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      element-desktop
      tutanota-desktop
      signal-desktop
    ];
 };
}
