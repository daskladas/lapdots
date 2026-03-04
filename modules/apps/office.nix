{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    libreoffice-still
  ];

  home-manager.users.${username}.programs = {
    onlyoffice.enable = true;
    zathura.enable = true;
  };
}
