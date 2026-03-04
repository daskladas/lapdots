{ username, pkgs, lib, ... }:
{
  home-manager.users.${username} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      
      profiles.default.extensions = with pkgs.vscode-extensions; [
        # Theme & Icons
        jdinhlife.gruvbox
        pkief.material-icon-theme
        
        # Visuell/Übersicht
        oderwat.indent-rainbow
        aaron-bond.better-comments
        usernamehw.errorlens
        
        # Produktivität
        christian-kohler.path-intellisense
        editorconfig.editorconfig
        
        # Nix
        jnoortheen.nix-ide
        mkhl.direnv
        
        # Git
        eamodio.gitlens
        github.vscode-pull-request-github
        
        # Python
        ms-python.python
        ms-python.debugpy
        
        # Java
        vscjava.vscode-java-pack
        vscjava.vscode-java-debug
        redhat.java
        
        # Web
        esbenp.prettier-vscode
        ritwickdey.liveserver
        
        # Config Files
        redhat.vscode-yaml
        redhat.vscode-xml
        mechatroner.rainbow-csv
        tamasfe.even-better-toml
        coolbear.systemd-unit-file
        mikestead.dotenv
        
        # Shell
        timonwong.shellcheck
        
        # C/C++
        ms-vscode.cmake-tools
        
        # Docker
        ms-azuretools.vscode-docker
        
        # AI - Error beim rebuilden wegen hash
        # anthropic.claude-code
      ];
      
      profiles.default.userSettings = lib.mkForce {
        # Theme & Icons
        "workbench.colorTheme" = "Gruvbox Dark Medium";
        "workbench.iconTheme" = "material-icon-theme";
        
        # Editor
        "editor.fontFamily" = "'Geist Mono Nerd Font', 'monospace'";
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true;
        "editor.lineNumbers" = "relative";
        "editor.minimap.enabled" = false;
        "editor.cursorBlinking" = "smooth";
        "editor.smoothScrolling" = true;
        
        # Transparenz
        "window.autoDetectColorScheme" = true;
        "window.titleBarStyle" = "custom";
        
                # Datei-Zuordnungen
        "files.associations" = {
          "*.nix" = "nix";
          "flake.lock" = "json";
        };

        # Sonstiges
        "files.autoSave" = "afterDelay";
        "telemetry.telemetryLevel" = "off";
        "update.mode" = "none";
      };
    };
  };
}
