{ pkgs,  ... }:
{
  environment.systemPackages = [
 pkgs.ntfs3g
 pkgs.openssl
 pkgs.obs-studio
 pkgs.tree
 pkgs.teamviewer
 pkgs.rustdesk-flutter
 pkgs.conky
 pkgs.curl
 pkgs.wget
 pkgs.flameshot
 pkgs.gparted
 pkgs.libreoffice-still
 pkgs.htop
 pkgs.mullvad-vpn
  ];
}
