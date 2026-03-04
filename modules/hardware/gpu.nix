{ config, lib, pkgs, ... }:

let
  cfg = config.hw.gpu;
in
{
  options.hw.gpu = {
    enable = lib.mkEnableOption "GPU support";
    brand = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "intel" "nvidia" "amd" ]);
      default = null;
      description = "GPU brand for driver selection";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    })

    (lib.mkIf (cfg.enable && cfg.brand == "nvidia") {
      services.xserver.videoDrivers = [ "nvidia" ];
      boot.kernelModules = [ "nvidia-uvm" ];
      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    })

    (lib.mkIf (cfg.enable && cfg.brand == "intel") {
      hardware.graphics.extraPackages = with pkgs; [
        vpl-gpu-rt
      ];
    })
  ];
}
