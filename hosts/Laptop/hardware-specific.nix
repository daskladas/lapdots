{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "mt7921e" ];
}
