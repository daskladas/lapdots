{ lib, config, pkgs, username, ... }:
let
  cfg = config.dev.virtualization;
in
{
  options.dev.virtualization = {
    enable = lib.mkEnableOption "virtualization (Docker, libvirtd, QEMU, virt-manager)";
  };

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;

    virtualisation = {
      docker.enable = true;
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

    users.users.${username}.extraGroups = [ "libvirtd" "docker" ];

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      qemu
      quickemu
      swtpm
    ];
  };
}
