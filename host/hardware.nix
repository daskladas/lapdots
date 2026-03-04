{ pkgs, ... }:
{
  # ThinkPad T14 Gen 2a
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "mt7921e" ];

  # Wayland session variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WEBKIT_DISABLE_COMPOSITING_MODE = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
