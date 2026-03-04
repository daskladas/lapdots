{ spicetify-nix, pkgs, lib, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [ spicetify-nix.nixosModules.default ];

  programs.spicetify = {
    enable = true;
    theme = lib.mkForce spicePkgs.themes.text;
    colorScheme = lib.mkForce "Gruvbox";
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
    ];
  };
}
