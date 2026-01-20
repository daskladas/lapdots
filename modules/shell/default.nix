{ pkgs, username, ... }:
{
  imports = [
    ./bash.nix
    ./p10k
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    acpi
    bat
    bat-extras.batman
    clang
    eza
    gh
    nixd
    nixfmt
    unzip
    zoxide
  ];
}
