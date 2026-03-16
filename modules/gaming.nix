{ lib, config, pkgs, ... }:
let
  cfg = config.gaming;
in
{
  options.gaming = {
    enable = lib.mkEnableOption "gaming profile";
    steam.enable = lib.mkEnableOption "Steam with Proton and gamemode";
    foss.enable = lib.mkEnableOption "open source games (Xonotic, SuperTuxKart, Luanti...)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      lib.optionals cfg.steam.enable [
        (discord.override {
          withOpenASAR = false;
          withVencord = true;
        })
        wineWowPackages.stable
      ]
      ++ lib.optionals cfg.foss.enable [
        xonotic
        mindustry
        luanti
        teeworlds
        hedgewars
        superTuxKart
        zeroad-unwrapped
        luanti-client
      ];

    programs = lib.mkIf cfg.steam.enable {
      steam = {
        enable = true;
        protontricks.enable = true;
      };
      gamemode.enable = true;
    };

    hardware.steam-hardware.enable = cfg.steam.enable;

    services.udev.extraRules = lib.mkIf cfg.steam.enable ''
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="044f", ATTRS{idProduct}=="b10a", TAG+="uaccess"
    '';
  };
}
