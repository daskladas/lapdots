{ inputs, system, ... }:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    desktopEnvironment = "hyprland";
    displayManager = "sddm";
    hostName = "Desktop";
    systemType = "desktop";
    username = "daskladas";
    wallpaper = "nix-colors.png";
    inherit system;
  }
  // inputs;
  modules = [
    ../.
    (
      { pkgs, ... }:
      {
        specs = {
          gpu.enable = true;
          gpu.brand = "amd";
        };
        devTools.enable = true;
        devTools.optionalPackages = [
          pkgs.zed-editor
        ];
        gaming.enable = true;
        contentcreation.enable = false;
      }
    )
  ];
}
