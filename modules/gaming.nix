{ lib, config, pkgs, ... }:

let
  cfg = config.gaming;
in
{
  options.gaming = {
    enable = lib.mkEnableOption "gaming profile with Steam, Wine, and open source games";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (discord.override {
        withOpenASAR = false;
        withVencord = true;
      })
      wineWowPackages.stable
      xonotic
      mindustry
      luanti
      teeworlds
      hedgewars
      superTuxKart
      zeroad-unwrapped
      luanti-client
    ];

    programs = {
      steam = {
        enable = true;
        protontricks.enable = true;
      };
      gamemode.enable = true;
    };

    hardware.steam-hardware.enable = true;

    services.udev.extraRules = ''
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="044f", ATTRS{idProduct}=="b10a", TAG+="uaccess"
    '';
  };
}
