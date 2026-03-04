{ pkgs, username, ... }:
{
  # ── Stylix ──
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
  };

  # ── Fonts ──
  fonts = {
    packages = with pkgs; [
      geist-font
      nerd-fonts.geist-mono
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts.emoji = [ "Noto Color Emoji" ];
  };

  # ── GTK + Cursor ──
  home-manager.users.${username} = {
    # Wallpapers + Logo
    home.file.".config/backgrounds".source = ../../assets/wallpapers;
    home.file.".config/nixlogo.svg".source = ../../assets/logo/nix-snowflake.svg;

    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.kora-icon-theme;
        name = "kora";
      };
      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };
  };

}
