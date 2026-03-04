{pkgs, username, lib, ...}:
{
  environment.systemPackages = with pkgs; [
    neovim
    cargo
    openssl
    python314
  ];

  home-manager.users.${username} = {
    # ── Git ──
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "daskladas";
          email = "xvzrsm@tutanota.de";
        };
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };

    # ── VSCodium ──
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      profiles.default.extensions = with pkgs.vscode-extensions; [
        jdinhlife.gruvbox
        pkief.material-icon-theme
        oderwat.indent-rainbow
        usernamehw.errorlens
        gruntfuggly.todo-tree
        eamodio.gitlens
        ms-python.python
        ms-python.vscode-pylance
        jnoortheen.nix-ide
        bbenoist.nix
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        redhat.vscode-yaml
        ritwickdey.liveserver
        tamasfe.even-better-toml
      ];

      profiles.default.userSettings = lib.mkForce {
        "editor.fontFamily" = "'GeistMono Nerd Font', 'monospace', monospace";
        "editor.fontSize" = 16;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.tabSize" = 2;
        "editor.wordWrap" = "on";
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings"."nixd" = { };
        "terminal.integrated.fontFamily" = "'GeistMono Nerd Font'";
        "terminal.integrated.fontSize" = 14;
        "workbench.colorTheme" = "Gruvbox Dark Hard";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
        "workbench.tree.indent" = 16;
        "files.associations" = {
          "*.nix" = "nix";
          "flake.lock" = "json";
        };
        "files.autoSave" = "afterDelay";
        "telemetry.telemetryLevel" = "off";
        "update.mode" = "none";
      };
    };
  };
}
