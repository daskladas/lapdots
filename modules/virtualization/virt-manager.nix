{ pkgs, username, ... }:
{
  programs.virt-manager.enable = true;
  
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  
  users.users.${username}.extraGroups = [ "libvirtd" ];
  
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    qemu
    swtpm
  ];
}
