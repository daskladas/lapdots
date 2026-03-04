{ username, ... }:
{
  # ── Bluetooth ──
  services.blueman.enable = true;

  # ── Flatpak ──
  services.flatpak.enable = true;

  # ── GNOME Keyring ──
  services.gnome.gnome-keyring.enable = true;

  # ── Virtual Filesystem ──
  services.gvfs.enable = true;

  # ── Power ──
  services.upower.enable = true;

  # ── SSH ──
  services.openssh = {
    enable = true;
    ports = [ 4545 ];
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.X11Forwarding = true;
  };

  # ── Network Manager Applet ──
  home-manager.users.${username} = {
    services.network-manager-applet.enable = true;
  };
}
