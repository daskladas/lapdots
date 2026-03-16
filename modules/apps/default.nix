{ username, ... }:
{
  imports = [
    ./browsing.nix
    ./communication.nix
    ./office.nix
    ./creative.nix
    ./entertainment.nix
    ./media.nix
    ./filemanager.nix
    ./terminals.nix
    ./terminal-fun.nix
    ./cybersec.nix
  ];

  # Electron Wayland flags (used by Discord, Signal, Teams, VSCodium)
  home-manager.users.${username}.home.file.".config/electron-flags.conf".source = ./electron-flags.conf;
}
