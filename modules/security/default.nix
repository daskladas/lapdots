{
  imports = [
    ./wallpaper-manager-sudoers.nix
    ./authentication
    ./encryption
    ./gnupg
    ./firejail.nix
    ./clamav.nix
    ./usbguard.nix
    ./hardening.nix
    ./aide.nix
  ];
}
