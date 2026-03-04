{ pkgs,  ... }:
{
  environment.systemPackages = [
 pkgs.ntfs3g
 pkgs.openssl
 pkgs.obs-studio
 pkgs.darktable
 pkgs.gimp-with-plugins
 pkgs.kdePackages.kdenlive
 pkgs.rustdesk-flutter
 pkgs.tree
 pkgs.cargo
 pkgs.conky
 pkgs.curl
 pkgs.wget
 pkgs.gparted
 pkgs.libreoffice-still
 pkgs.htop
 pkgs.mullvad-vpn
  ];
}
