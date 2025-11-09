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
    ({ lib, ... }: {
      programs.kitty = {
        enable = true;
        settings = {
          background_opacity = lib.mkForce "0.50";  
          font_size = "14.0";
        };
      };
    })
  ];
}
