{ inputs, pkgs, lib, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [ inputs.spicetify-nix.nixosModules.default ];

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
