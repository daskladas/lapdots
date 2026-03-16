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
}
