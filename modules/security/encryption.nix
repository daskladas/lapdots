{ pkgs, username, inputs, ... }:
{
  # ── Agenix ──
  environment.systemPackages = [
    inputs.agenix.packages."${pkgs.stdenv.hostPlatform.system}".default
    pkgs.bitwarden-desktop
    pkgs.proton-authenticator
    pkgs.pinentry-curses
    pkgs.pinentry-gnome3
  ];

  age = {
    identityPaths = [ "/home/${username}/.ssh/agenix_key" ];
    secrets = { };
  };

  # ── GnuPG ──
  programs.gnupg = {
    agent.enable = true;
    agent.enableSSHSupport = true;
  };

  home-manager.users.${username} = {
    home.file.".gnupg/gpg-agent.conf".source = ./gpg-agent.conf;
  };
}
