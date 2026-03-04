{ ... }:
{
  # ── Bootloader ──
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.tmp.cleanOnBoot = true;

  # ── Kernel ──
  boot.kernelParams = [
    "psmouse.synaptics_intertouch=0"
    "quiet"
    "udev.log_level=3"
  ];

  # ── Plymouth ──
  boot.plymouth.enable = true;
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
}
