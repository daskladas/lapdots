<div align="center">

# daskladas's NixOS Dotfiles

_Declarative NixOS configuration with Flakes & Home Manager_

[![NixOS](https://img.shields.io/badge/NixOS-Unstable-blue.svg?style=flat&logo=nixos&logoColor=white)](https://nixos.org)
[![Hyprland](https://img.shields.io/badge/WM-Hyprland-teal.svg?style=flat)](https://hyprland.org)

</div>

---

## 📋 System Information

- **OS**: NixOS (Unstable channel)
- **Desktop**: Hyprland with UWSM (Universal Wayland Session Manager)
- **Filesystem**: Btrfs with compression
- **Package Manager**: Nix with Flakes
- **Configuration**: Fully declarative and reproducible
- **Hosts**: Desktop (AMD/NVIDIA) and Laptop (Intel) configurations

---

## ✨ Features

- 🎨 **Modular Configuration**: Clean separation of concerns
- 🔒 **Security-First**: Hardened setup with defense-in-depth
- 🏠 **Homelab Ready**: Designed for self-hosted infrastructure
- 🎮 **Gaming Support**: Steam, Lutris, and more
- 💻 **Development Tools**: Full dev stack included
- 📦 **Reproducible**: Everything is declarative
- 🖥️ **Multi-Host**: Separate configs for Desktop and Laptop

---

## 🚀 Installation

### Fresh Installation
```bash
# Clone the repository
git clone https://shit.homeserveris.online:8443/daskladas/nix-dots.git
cd nix-dots

# Partition and format disk with Disko
sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount ./disko-defaults.nix

# Install NixOS (choose Desktop OR Laptop)
sudo nixos-install --flake .#Desktop
# OR
sudo nixos-install --flake .#Laptop
```

### Existing System
```bash
# Clone the repository
git clone https://shit.homeserveris.online:8443/daskladas/nix-dots.git
cd nix-dots

# Apply configuration (choose your host)
sudo nixos-rebuild switch --flake .#Desktop
# OR
sudo nixos-rebuild switch --flake .#Laptop
```

---

## 🛠️ System Management

| Command                                       | Description                          |
| --------------------------------------------- | ------------------------------------ |
| `sudo nixos-rebuild switch --flake .#Desktop` | Apply and activate system changes    |
| `nixos-rebuild test --flake .#Desktop`        | Test configuration without switching |
| `nix flake update`                            | Update all flake inputs              |
| `nix flake check`                             | Validate flake configuration         |
| `sudo nix-collect-garbage -d`                 | Clean old generations                |

---

## 🔧 Troubleshooting

| Command                                                     | Description                                 |
| ------------------------------------------------------------| --------------------------------------------|
| `sudo nixos-rebuild switch --flake .#Desktop --show-trace`  | Show detailed error trace                   |
| `nix flake update`                                          | Update dependencies (may fix build issues)  |
| `nix flake check`                                           | Validate configuration syntax               |
| `find /etc/nixos -name "filename"`                          | Find specific file by name                  |
| `find /etc/nixos -name "*.nix"`                             | Find all .nix files                         |
| `grep -rn "search-text" /etc/nixos --include="*.nix"`       | Find files containing specific text         |
| `grep -rl "search-text" /etc/nixos`                         | List files containing text (no line numbers)|
| `sudo nix-store --verify --check-contents`                  | Verify Nix store integrity                  |
| `journalctl -xeu nixos-rebuild`                             | Check rebuild logs                          |

---

<div align="center">

_Built with ❤️ and lots of ☕_

**[⭐ Star this repo](https://shit.homeserveris.online:8443/daskladas/nix-dots) if you found it helpful!**

Special thanks to [@c0d3h01](https://github.com/c0d3h01) for the inspiration and initial setup!

</div>