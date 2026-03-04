{
  description = "NixOS — ThinkPad T14 Gen 2a";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations.Laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        username = "daskladas";
        # TEMPORARY — will be removed as modules are migrated
        desktopEnvironment = "hyprland";
        displayManager = "greetd";
        hostName = "Laptop";
        wallpaper = "nix-colors.png";
      } // inputs; # TEMPORARY — entertainment.nix, age.nix destructure inputs directly
      modules = [ ./configuration.nix ];
    };
  };
}
