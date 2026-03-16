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
  #  COCKPIT — central control panel
  #  Toggle features on/off from one place.
  #  Main toggles enable the entire category,
  #  sub-toggles control individual components.
  # ═══════════════════════════════════════════════

  networking.hostName = "Laptop";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # ── Hardware ──────────────────────────────────
  hw.gpu               = { enable = true; brand = "intel"; };
  hw.bluetooth.enable  = true;

  # ── Apps ──────────────────────────────────────
  apps.browsing.enable       = true;
  apps.communication.enable  = true;
  apps.creative.enable       = true;
  apps.entertainment.enable  = true;
  apps.filemanager.enable    = true;
  apps.media.enable          = true;
  apps.office.enable         = true;
  apps.terminals.enable      = true;
  apps.terminal-fun.enable   = true;

  # ── Gaming ────────────────────────────────────
  gaming.enable = false;

  # ── Dev ───────────────────────────────────────
  dev.tools.enable           = true;
  dev.virtualization.enable  = true;

  # ── Security ──────────────────────────────────
  security.sandboxing.enable  = true;   # Firejail
  security.antivirus.enable   = true;   # ClamAV
  security.integrity.enable   = true;   # AIDE
  security.usb.enable         = true;   # USBGuard
  security.hardening.enable   = true;   # Kernel sysctl + auditd

  # ── Pentesting ────────────────────────────────
  #  Master toggle — set to false to disable all
  cybersec.enable = true;
  #  Sub-toggles — pick what you need
    cybersec.recon.enable             = true;
    cybersec.web.enable               = true;
    cybersec.code-scanning.enable     = true;
    cybersec.osint.enable             = true;
    cybersec.active-directory.enable  = true;
    cybersec.mobile.enable            = true;
    cybersec.network.enable           = true;
    cybersec.wireless.enable          = true;
    cybersec.crypto.enable            = true;
    cybersec.voip.enable              = true;
    cybersec.passwords.enable         = true;
    cybersec.privesc.enable           = true;
    cybersec.forensics.enable         = true;
    cybersec.exploitation.enable      = true;
    cybersec.reversing.enable         = true;
    cybersec.enumeration.enable       = true;
    cybersec.utilities.enable         = true;
}
