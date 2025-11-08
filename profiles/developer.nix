{
  lib,
  config,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.devTools;
  defaultPackages = [
    #--- Editors ---#
    pkgs.vscodium
    #--- Tools ---#
    # pkgs.nodejs_24
    pkgs.python314
    pkgs.libgcc
    pkgs.gnumake
    pkgs.neovim
    pkgs.gitkraken
    pkgs.nodejs_latest
    pkgs.nodePackages.prettier
    pkgs.nix-output-monitor
  ];
in
{
  options.devTools = {
    enable = mkEnableOption "Enable developer tools";

    optionalPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      example = [
        pkgs.nodejs_latest
        pkgs.gitkraken
      ];
      description = "List of optional packages to install alongside the default ones.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = defaultPackages ++ cfg.optionalPackages;
  };
}
