{
  username,
  wallpaper,
  ...
}:
{
  home-manager.users.${username} = _: {
    services.hyprpaper = {
      enable = false;
      settings = {
        preload = [ "/home/${username}/.config/backgrounds/${wallpaper}" ];
        wallpaper = [
          " , ~/.config/backgrounds/${wallpaper}"
        ];
      };
    };
  };
}
