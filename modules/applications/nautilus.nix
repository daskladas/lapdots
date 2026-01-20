{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    nautilus
    file-roller
  ];

  services.gvfs.enable = true;

  home-manager.users.${username} = {
    dconf.settings = {
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        show-hidden-files = true;
      };
      "org/gnome/nautilus/list-view" = {
        default-zoom-level = "small";
        use-tree-view = true;
      };
      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true;
        sort-directories-first = true;
        view-type = "list";
      };
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      music = null;
      videos = null;
      templates = null;
      publicShare = null;
    };

    xdg.mimeApps.defaultApplications = {
      "inode/directory" = "org.gnome.Nautilus.desktop";
    };

    xdg.configFile."gtk-3.0/bookmarks".text = ''
      file:///etc/nixos NixOS Config
      file:///home/${username}/Downloads Downloads
      file:///home/${username}/Documents Dokumente
      file:///home/${username}/Pictures Bilder
      file:///home/${username}/.config Config
      file:///tmp Temp
      file:///mnt Mounts
    '';
  };
}
