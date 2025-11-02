{ pkgs, ... }:
let
  hyprland-kath-theme = pkgs.stdenv.mkDerivation {
    name = "sddm-astronaut-hyprland-kath";
    src = pkgs.fetchFromGitHub {
      owner = "keyitdev";
      repo = "sddm-astronaut-theme";
      rev = "master";
      sha256 = "sha256-ITufiMTnSX9cg83mlmuufNXxG1dp9OKG90VBZdDeMxw=";
    };
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sddm-astronaut-theme
      cp -r * $out/share/sddm/themes/sddm-astronaut-theme/
      
      # Setze Hyprland Kath als Standard
      sed -i 's|ConfigFile=Themes/astronaut.conf|ConfigFile=Themes/hyprland_kath.conf|' \
        $out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
    '';
  };
in
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      package = pkgs.kdePackages.sddm;
    };
  };
  
  environment.systemPackages = with pkgs; [
    hyprland-kath-theme
    kdePackages.qt6ct
    kdePackages.qtsvg
    kdePackages.qtvirtualkeyboard
    kdePackages.qtmultimedia
  ];
}
