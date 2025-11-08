{ lib, ... }:

{
  imports = [
    ./pkgs
    ./browsing
    ./electron
    ./t4l
    ./communication.nix
    ./entertainment.nix
    ./office.nix
    ./media.nix
    ./productivity.nix
    ./virtualization.nix
    ./wezterm.nix
    ./terminal-fun.nix
  ];

home-manager.sharedModules = [
    (_: {
      programs.kitty = {
        enable = true;
        settings = {
          background_opacity = "0.50";  
        };
      };
    })
  ];}
