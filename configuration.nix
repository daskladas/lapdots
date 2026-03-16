{ inputs, ... }:
{
  imports = [
    # Flake modules
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix

    # Host
    ./host/hardware-configuration.nix
    ./host/hardware.nix
    ./host/locale.nix

    # Modules
    ./modules
    ./users
  ];

  # ═══════════════════════════════════════════════
  #  SCHALTZENTRALE
  # ═══════════════════════════════════════════════

  networking.hostName = "Laptop";

  # Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Hardware
  hw.gpu = { enable = true; brand = "intel"; };

  # Profiles
  gaming.enable = false;
  apps.creative.enable = true;
  apps.office.enable = true;
  apps.entertainment.enable = true;
  apps.browsing.enable = true;
  apps.communication.enable = true;
  apps.media.enable = true;
  apps.filemanager.enable = true;
  apps.terminals.enable = true;
  apps.terminal-fun.enable = true;

  # Security
  security.sandboxing.enable = true;
  security.antivirus.enable = true;
  security.integrity.enable = true;
  security.usb.enable = true;
  security.hardening.enable = true;

  # Pentesting
  cybersec.enable = true;
  cybersec.recon.enable = true;
  cybersec.web.enable = true;
  cybersec.code-scanning.enable = true;
  cybersec.osint.enable = true;
  cybersec.active-directory.enable = true;
  cybersec.mobile.enable = true;
  cybersec.network.enable = true;
  cybersec.wireless.enable = true;
  cybersec.crypto.enable = true;
  cybersec.voip.enable = true;
  cybersec.passwords.enable = true;
  cybersec.privesc.enable = true;
  cybersec.forensics.enable = true;
  cybersec.exploitation.enable = true;
  cybersec.reversing.enable = true;
  cybersec.enumeration.enable = true;
  cybersec.utilities.enable = true;

  # Dev
  dev.tools.enable = true;
}
