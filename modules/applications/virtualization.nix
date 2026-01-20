{ pkgs, username, ... }:
{
  home-manager.users.${username}.home.packages = with pkgs; [
    qemu
    quickemu
  ];
  programs.virt-manager.enable = true;
  users.users.${username}.extraGroups = [ "libvirtd" "docker" ];
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
