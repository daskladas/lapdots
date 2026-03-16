{ lib, config, ... }:
let
  cfg = config.hw.bluetooth;
in
{
  options.hw.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth support (disabled on boot by default)";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          Experimental = true;
        };
        Policy = {
          AutoEnable = false;
        };
      };
    };
  };
}
