<h1 align="center">
   <img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-colours.svg" width="100px" />
   <br>
   lapdots — ThinkPad T14 Gen 2a
   <br>
   <div align="center">
      <p></p>
      <div align="center">
         <a href="https://nixos.org">
            <img src="https://img.shields.io/badge/NixOS-Unstable-blue?style=for-the-badge&logo=NixOS&logoColor=91D7E3&label=NixOS&labelColor=303446&color=91D7E3">
         </a>
         <a href="https://hyprland.org">
            <img src="https://img.shields.io/badge/WM-Hyprland-teal?style=for-the-badge&logo=hyprland&logoColor=white&labelColor=303446&color=89DCEB">
         </a>
         <a href="https://github.com/danth/stylix">
            <img src="https://img.shields.io/badge/Theme-Gruvbox-orange?style=for-the-badge&labelColor=303446&color=d4be98">
         </a>
      </div>
      <br>
   </div>
</h1>

<p align="center">
  <img src="assets/screenshot.png" width="100%" />
</p>

---

## 📋 System Information

|                |                                        |
| -------------- | -------------------------------------- |
| **Host**       | Lenovo ThinkPad T14 Gen 2a (AMD Ryzen) |
| **OS**         | NixOS Unstable with Flakes             |
| **WM**         | Hyprland + UWSM + HyprPanel           |
| **Theme**      | Gruvbox Dark Hard (via Stylix)         |
| **Shell**      | Zsh + Powerlevel10k                    |
| **Terminal**   | Kitty                                  |
| **Editor**     | VSCodium / Neovim                      |
| **Browser**    | Chromium (Firejailed)                  |
| **Filesystem** | Btrfs with auto-scrub & balance        |

---

## 🏗️ Structure

<p align="center">
  <img src="assets/flake-structure.svg" width="100%" />
</p>

<details>
<summary>File tree</summary>

```
/etc/nixos/
├── flake.nix                 # Flake inputs & system entry point
├── configuration.nix         # Schaltzentrale — all imports & toggles
├── host/
│   ├── hardware-configuration.nix
│   ├── hardware.nix          # Kernel, mt7921e, Wayland env vars
│   └── locale.nix
├── modules/
│   ├── core/
│   │   ├── boot.nix          # systemd-boot, Plymouth, kernel params
│   │   ├── nix.nix           # Nix settings, GC, Btrfs maintenance
│   │   └── services.nix      # Blueman, Flatpak, GNOME Keyring, SSH
│   ├── desktop/
│   │   ├── hyprland.nix      # Hyprland config, keybinds, monitors
│   │   ├── hyprpanel.nix     # HyprPanel bar configuration
│   │   ├── greetd.nix        # TUI greeter
│   │   ├── rofi.nix          # App launcher (+config.rasi)
│   │   ├── styling.nix       # Stylix, fonts, GTK, cursors, wallpapers
│   │   └── xdg.nix           # MIME defaults, portals, user dirs
│   ├── apps/
│   │   ├── browsing.nix      # Chromium
│   │   ├── communication.nix # Signal, Discord, Tutanota
│   │   ├── creative.nix      # GIMP, Darktable, Kdenlive, OBS
│   │   ├── entertainment.nix # Spicetify (Spotify)
│   │   ├── filemanager.nix   # Nautilus
│   │   ├── media.nix         # VLC, Zathura
│   │   ├── office.nix        # LibreOffice, OnlyOffice
│   │   ├── terminals.nix     # Kitty
│   │   ├── terminal-fun.nix  # Pipes, CMatrix, cowsay
│   │   └── cybersec.nix      # 150+ pentesting tools
│   ├── dev/
│   │   ├── tools.nix         # VSCodium, Git, Neovim, Cargo
│   │   ├── virtualization.nix# Docker, libvirtd, QEMU
│   │   ├── shell.nix         # Zsh, P10k, Fastfetch, aliases
│   │   └── commonAliases.nix # Shared shell aliases
│   ├── security/
│   │   ├── auth.nix          # PAM, SSH, sudo rules
│   │   ├── encryption.nix    # Agenix, GnuPG
│   │   ├── firejail.nix      # Sandboxed apps
│   │   ├── hardening.nix     # Kernel sysctl, auditd
│   │   ├── usbguard.nix      # USB device whitelisting
│   │   ├── clamav.nix        # Antivirus + realtime scanning
│   │   └── aide.nix          # File integrity monitoring
│   ├── hardware/
│   │   ├── audio.nix         # Pipewire + parametric EQ
│   │   ├── bluetooth.nix     # Bluetooth (off by default)
│   │   ├── gpu.nix           # Intel/NVIDIA (mkEnableOption)
│   │   ├── network.nix       # NetworkManager, WireGuard, Tailscale
│   │   ├── peripherals.nix   # Printing, webcam
│   │   └── power.nix         # auto-cpufreq, AMD pstate
│   └── gaming.nix            # Steam, Wine (disabled)
├── users/daskladas/default.nix
├── scripts/                  # Wallpaper manager, rofi modes
└── assets/                   # Screenshot, flake diagram
```

</details>

---

## ✨ Features

- **Flat & readable** — max 2 levels of nesting, no empty wrapper files
- **Security-first** — Firejail sandboxing, USBGuard, ClamAV realtime, AIDE integrity, kernel hardening, auditd
- **Declarative** — single `configuration.nix` controls everything
- **`mkEnableOption` toggles** — `gaming.enable`, `hw.gpu.enable` / `hw.gpu.brand`
- **Stylix theming** — Gruvbox Dark Hard applied system-wide
- **Pentesting ready** — 150+ security tools in `cybersec.nix`

---

## 🚀 Usage

```bash
# Clone
git clone git@github.com:daskladas/lapdots.git /etc/nixos

# Apply
sudo nixos-rebuild switch

# Update inputs
sudo nix flake update
sudo nixos-rebuild switch

# Test without activating
sudo nixos-rebuild dry-build
```

---

## 🛠️ Management

| Command                        | Description                      |
| ------------------------------ | -------------------------------- |
| `sudo nixos-rebuild switch`    | Apply & activate                 |
| `sudo nixos-rebuild dry-build` | Test build without applying      |
| `nix flake update`             | Update all inputs                |
| `sudo nix-collect-garbage -d`  | Remove old generations           |
| `nh os switch`                 | Rebuild via nh (prettier output) |

---

## 🔧 Troubleshooting

| Command                                  | Description            |
| ---------------------------------------- | ---------------------- |
| `nixos-rebuild switch --show-trace`      | Detailed error trace   |
| `journalctl -xeu home-manager-daskladas` | Home Manager logs      |
| `systemctl --user status hyprpanel`      | HyprPanel status       |
| `aide-check`                             | File integrity check   |
| `clamscan-status`                        | Last antivirus scan    |
| `audit-log`                              | Recent security events |
| `usb-list`                               | All USB devices        |

---

<div align="center">

_Built with ❤️ and mass amounts of ☕_

Special thanks to [@c0d3h01](https://github.com/c0d3h01) for the inspiration and initial setup!

</div>
