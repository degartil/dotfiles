# Dotfiles

My personal NixOS configuration and Home Manager.

## Stack

- **OS:** NixOS Unstable
- **Desktop:** Niri + DankMaterialShell
- **Theme:** Gruvbox Dark via Stylix
- **Terminal:** Alacritty
- **Shell:** Nushell
- **Multiplexer:** Zellij
- **Editor:** Helix

## Structure

```text
.
├── flake.nix       # Flake definition
├── hosts/nixos/    # System and hardware configuration
├── modules/        # Home Manager and application modules
└── home/           # Wallpapers and additional configurations
```

## Usage

To rebuild the system:

```sh
sudo nixos-rebuild switch --flake .#nixos
```

> **Note:** This configuration is tailored to my hardware and preferences. Review the disk, encryption, and hardware settings before using it on another machine.
