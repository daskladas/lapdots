{ pkgs, ... }:
{
  boot.initrd.availableKernelModules = [
    "usb_storage"
  ];
  boot.kernelPackages = pkgs.linuxPackages; # Switch from Zen to stable kernel (fix steam-game-crashes - RDNA3 GPU timeouts)

}
