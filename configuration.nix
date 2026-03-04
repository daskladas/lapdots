{ inputs, ... }:
{
  imports = [
    # Flake modules
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix

    # Host (NEW — replaces hosts/Laptop + hosts/common)
    ./host/hardware-configuration.nix
    ./host/hardware.nix
    ./host/locale.nix

    # Modules (OLD paths — will be reorganized in later phases)
    ./modules
    ./users
  ];

  # ═══════════════════════════════════════════════
  #  SCHALTZENTRALE
  # ═══════════════════════════════════════════════

  networking.hostName = "Laptop";

  # Hardware

  # Profiles
  # Hardware
  hw.gpu = { enable = true; brand = "intel"; };
  gaming.enable = false;
}
