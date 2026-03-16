{ lib, config, pkgs, ... }:
let
  cfg = config.apps.terminal-fun;
in
{
  options.apps.terminal-fun = {
    enable = lib.mkEnableOption "terminal fun tools (cmatrix, cowsay, cava, asciiquarium...)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cmatrix
      sl
      cowsay
      figlet
      lolcat
      fortune
      toilet
      asciiquarium
      pipes
      cbonsai
      mapscii
      peaclock
      cava
      bastet
      gotop
      bb
    ];
  };
}
