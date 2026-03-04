{ pkgs, username, ... }:
{
  # ── State Versions (DO NOT CHANGE) ──
  system.stateVersion = "23.11";
  home-manager.users.${username} = {
    home.stateVersion = "23.11";
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  # ── Nix Package & Path ──
  nix = {
    package = pkgs.nixVersions.latest;
    nixPath = [ "nixpkgs=/run/current-system/nixpkgs/" ];
  };

  system.systemBuilderCommands = ''
    ln -sv ${pkgs.path} $out/nixpkgs
  '';

  # ── Nix Settings ──
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" ];
    extra-substituters = [
      "https://devenv.cachix.org"
      "https://zed-industries.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "zed-industries.cachix.org-1:QW3RoXK0Lm4ycmU5/3bmYRd3MLf4RbTGPqRulGlX5W0="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  # ── Garbage Collection ──
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  # ── Nixpkgs Config ──
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-32.3.3"
    ];
  };

  # ── System Tools ──
  systemd.tpm2.enable = false;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
  };

  programs.nix-ld = {
    enable = true;
    libraries = (pkgs.steam-run.args.multiPkgs pkgs) ++ [
      pkgs.stdenv.cc.cc.lib
    ];
  };

  environment.systemPackages = with pkgs; [
    sbctl
    ntfs3g
    curl
    wget
    gparted
    openssl
    mullvad-vpn
  ];

  # ── Btrfs Maintenance ──
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  systemd.timers."btrfs-balance" = {
    enable = true;
    timerConfig = {
      OnCalendar = "weekly";
      RandomizedDelaySec = "1h";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };

  systemd.services."btrfs-balance" = {
    script = ''
      if command -v upower >/dev/null && upower -i $(upower -e | grep BAT) | grep -q 'state:\s*discharging'; then
        echo "On battery, skipping btrfs balance"
        exit 0
      fi
      /run/current-system/sw/bin/btrfs balance start -dusage=75 -musage=75 -susage=75 -v --background --noflush /
    '';
    serviceConfig = {
      Type = "oneshot";
      Nice = 19;
      IOSchedulingClass = "idle";
      IOSchedulingPriority = 7;
      CPUWeight = 1;
    };
  };

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };
}
