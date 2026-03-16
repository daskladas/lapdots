{ lib, config, pkgs, ... }:
let
  cfg = config.security.sandboxing;
in
{
  options.security.sandboxing = {
    enable = lib.mkEnableOption "Firejail sandboxing for browsers and apps";
  };

  config = lib.mkIf cfg.enable {
    programs.firejail = {
      enable = true;
      wrappedBinaries = {
        brave = {
          executable = "${pkgs.brave}/bin/brave";
          profile = "${pkgs.firejail}/etc/firejail/brave.profile";
        };
        discord = {
          executable = "${pkgs.discord}/bin/discord";
          profile = "${pkgs.firejail}/etc/firejail/discord.profile";
        };
        signal-desktop = {
          executable = "${pkgs.signal-desktop}/bin/signal-desktop";
          profile = "${pkgs.firejail}/etc/firejail/signal-desktop.profile";
        };
        libreoffice = {
          executable = "${pkgs.libreoffice}/bin/libreoffice";
          profile = "${pkgs.firejail}/etc/firejail/libreoffice.profile";
        };
      };
    };
  };
}
