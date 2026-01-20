{ pkgs, ... }:
{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      # Browser
      chromium = {
        executable = "${pkgs.chromium}/bin/chromium";
        profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
      };
      brave = {
        executable = "${pkgs.brave}/bin/brave";
        profile = "${pkgs.firejail}/etc/firejail/brave.profile";
      };
      
      # Kommunikation
      discord = {
        executable = "${pkgs.discord}/bin/discord";
        profile = "${pkgs.firejail}/etc/firejail/discord.profile";
      };
      signal-desktop = {
        executable = "${pkgs.signal-desktop}/bin/signal-desktop";
        profile = "${pkgs.firejail}/etc/firejail/signal-desktop.profile";
      };
      teams-for-linux = {
        executable = "${pkgs.teams-for-linux}/bin/teams-for-linux";
        profile = "${pkgs.firejail}/etc/firejail/teams-for-linux.profile";
      };
      
      # Medien
      spotify = {
        executable = "${pkgs.spotify}/bin/spotify";
        profile = "${pkgs.firejail}/etc/firejail/spotify.profile";
      };
      
      # Office
      libreoffice = {
        executable = "${pkgs.libreoffice}/bin/libreoffice";
        profile = "${pkgs.firejail}/etc/firejail/libreoffice.profile";
      };
    };
  };
}
