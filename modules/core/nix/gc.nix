{ ... }:
{
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
  nix.settings.auto-optimise-store = true;

  # Maximal 3 Generationen im Boot-Menü
  boot.loader.systemd-boot.configurationLimit = 3;
}
