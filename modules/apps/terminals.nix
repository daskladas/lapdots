{ lib, username, ... }:
{
  home-manager.users.${username} = {
    # ── Kitty ──
    programs.kitty = {
      enable = true;
      settings = {
        background_opacity = lib.mkForce "0.50";
        font_size = "14.0";
      };
    };

    # ── Wezterm ──
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = ''
        return {
          font = wezterm.font("GeistMono Nerd Font"),
          font_size = 14.0,
          color_scheme = "gruvbox_material_dark_hard",
          color_schemes = {
              ["gruvbox_material_dark_hard"] = {
                  foreground = "#D4BE98",
                  background = "#1D2021",
                  cursor_bg = "#D4BE98",
                  cursor_border = "#D4BE98",
                  cursor_fg = "#1D2021",
                  selection_bg = "#D4BE98" ,
                  selection_fg = "#3C3836",

                  ansi = {"#1d2021","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"},
                  brights = {"#eddeb5","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"},
              },
          },
          enable_tab_bar = false,
          window_background_opacity = 0.5
        }
      '';
    };

    # ── Cinnamon terminal default ──
    dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "wezterm";
  };
}
