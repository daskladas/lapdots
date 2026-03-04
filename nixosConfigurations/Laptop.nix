{ inputs, system, ... }:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    desktopEnvironment = "hyprland";
    displayManager = "greetd";
    hostName = "Laptop";
    systemType = "desktop";
    username = "daskladas";
    wallpaper = "nix-colors.png";
    inherit system;
  }
  // inputs;
  modules = [
    ../.
    (
      { ... }:
      {
        specs = {
          gpu.enable = true;
          gpu.brand = "intel";
        };
        devTools.enable = true;
        gaming.enable = false;
      }
    )
  ];
}
