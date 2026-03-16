{ inputs, pkgs, lib, config, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  cfg = config.apps.entertainment;
in {
  imports = [ inputs.spicetify-nix.nixosModules.default ];

  options.apps.entertainment = {
    enable = lib.mkEnableOption "entertainment apps (Spotify with Spicetify)";
  };

  config = lib.mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      theme = lib.mkForce spicePkgs.themes.text;
      colorScheme = lib.mkForce "Gruvbox";
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        shuffle
      ];
    };
  };
}
