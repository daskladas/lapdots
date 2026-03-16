{ lib, config, pkgs, username, ... }:
let
  cfg = config.apps.media;
in
{
  options.apps.media = {
    enable = lib.mkEnableOption "media apps (VLC)";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username}.home.packages = with pkgs; [
      vlc
    ];
  };
}
