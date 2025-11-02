{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      bitwarden-desktop
      #bitwarden-cli
      #bitwarden-menu
      proton-authenticator
    ];
  };
}
