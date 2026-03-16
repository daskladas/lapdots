{ lib, config, pkgs, username, ... }:
let
  cfg = config.apps.office;
in
{
  options.apps.office = {
    enable = lib.mkEnableOption "office apps (LibreOffice, OnlyOffice, Zathura)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-still
    ];

    home-manager.users.${username}.programs = {
      onlyoffice.enable = true;
      zathura.enable = true;
    };
  };
}
