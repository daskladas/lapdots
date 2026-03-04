{ pkgs, username, lib, ... }:

let
  myAliases = import ./commonAliases.nix;
  color1 = "#d6bc5d"; color2 = "#00FFFF"; color3 = "#40E0D0"; color4 = "#32CD32";
  color5 = "#e5c100"; color6 = "#088F8F"; color7 = "#B4C424"; color8 = "#c59c79";
  color9 = "#50C878"; color10 = "#40B5AD";
in
{
  # ── Zsh ──
  home-manager.users.${username} = { config, ... }: {
    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = myAliases;
      history = {
        size = 10000;
        path = "$HOME/.config/zsh/.zsh_history";
      };
      initContent = lib.mkOrder 550 ''
        [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
        eval "$(zoxide init --cmd cd zsh)"
      '';
      plugins = [
        { name = "powerlevel10k"; src = pkgs.zsh-powerlevel10k; file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme"; }
        { name = "zsh-autocomplete"; src = pkgs.zsh-autocomplete; file = "share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"; }
      ];
    };

    # P10k config
    home.file.".config/zsh/.p10k.zsh".source = ./p10k.zsh;

    # ── Fastfetch ──
    programs.fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
      settings = {
        "$schema" = "https:#github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = { source = ./nixos.png; height = 18; width = 35; padding = { top = 1; left = 2; }; };
        modules = [
          "break"
          { type = "command"; text = "echo \${USER}@\${HOSTNAME}"; key = "      "; keyColor = color10; }
          { type = "custom"; format = "┌──────────────────────Hardware──────────────────────┐"; }
          { type = "host"; key = "   PC"; keyColor = color1; }
          { type = "cpu"; key = "   CPU"; showPeCoreCount = true; keyColor = color2; }
          { type = "gpu"; key = "  󰊴 GPU"; keyColor = color3; }
          { type = "memory"; key = "  󰑭 Memory"; keyColor = color4; }
          { type = "disk"; key = "   Disk"; keyColor = color5; }
          { type = "display"; key = "  󰍹 Display"; keyColor = color6; }
          { type = "custom"; format = "└────────────────────────────────────────────────────┘"; }
          "break"
          { type = "custom"; format = "┌──────────────────────Software──────────────────────┐"; }
          { type = "os"; key = "   OS"; keyColor = color7; }
          { type = "kernel"; key = "   Kernel"; keyColor = color7; }
          { type = "packages"; key = "  󰏖 Packages"; keyColor = color8; }
          { type = "de"; key = " DE"; keyColor = color9; }
          { type = "wm"; key = "   WM"; keyColor = color8; }
          { type = "terminal"; key = "   Terminal"; keyColor = color9; }
          { type = "shell"; key = "   Shell"; keyColor = color9; }
          { type = "custom"; format = "└────────────────────────────────────────────────────┘"; }
          "break"
          { type = "custom"; format = "┌────────────────────Uptime/Age──────────────────────┐"; }
          { type = "command"; key = "  OS Age"; keyColor = color10; text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days"; }
          { type = "uptime"; key = "  Uptime"; keyColor = color10; }
          { type = "custom"; format = "└────────────────────────────────────────────────────┘"; }
          { type = "colors"; paddingLeft = 2; symbol = "circle"; }
          "break"
        ];
      };
    };
  };

  # ── Bash (fallback) ──
  programs.bash = {
    completion.enable = true;
    shellAliases = myAliases;
    interactiveShellInit = ''
      eval "$(zoxide init --cmd cd bash)"
    '';
  };

  # ── Shell packages ──
  environment.systemPackages = with pkgs; [
    bat
    bat-extras.batman
    eza
    fzf
    gh
    nixd
    ripgrep
    tree
    htop
    btop
    resources
    vulnix
    cava
    zoxide
    appimage-run
  ];

  # ── AppImage support ──
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
