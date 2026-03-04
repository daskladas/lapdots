{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./hyprpanel.nix
    ./greetd.nix
    ./rofi.nix
    ./styling.nix
    ./xdg.nix
  ];

  programs.dconf.enable = true;

  # Hyprland ecosystem packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    grim
    gthumb
    ags
    libnotify
    networkmanagerapplet
    pavucontrol
    playerctl
    pywal
    slurp
    wl-clipboard
    zenity
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.uwsm.enable = true;
  programs.hyprlock.enable = true;
}
