{ pkgs, ... }:
{
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
}
