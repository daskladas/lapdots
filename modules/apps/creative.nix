{ lib, config, pkgs, ... }:
let
  cfg = config.apps.creative;
in
{
  options.apps.creative = {
    enable = lib.mkEnableOption "creative apps (GIMP, Darktable, Kdenlive, OBS)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      darktable
      gimp-with-plugins
      kdePackages.kdenlive
    ];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };
  };
}
