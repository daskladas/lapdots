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
    ./profiles
    ./assets
    ./scripts
    ./users
  ];

  # ═══════════════════════════════════════════════
  #  SCHALTZENTRALE
  # ═══════════════════════════════════════════════

  networking.hostName = "Laptop";

  # Hardware
  specs.gpu = { enable = true; brand = "intel"; };

  # Profiles
  devTools.enable = true;
  gaming.enable = false;
}
