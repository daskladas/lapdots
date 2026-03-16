{ lib, config, pkgs, username, ... }:
let
  cfg = config.apps.communication;
in
{
  options.apps.communication = {
    enable = lib.mkEnableOption "communication apps (Signal, Discord, Tutanota, LocalSend)";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        tutanota-desktop
        signal-desktop
        (discord.override {
          withOpenASAR = false;
          withVencord = true;
        })
        localsend
        rustdesk-flutter
      ];
    };
  };
}
