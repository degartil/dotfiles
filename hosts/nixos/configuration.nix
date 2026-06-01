{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      systemd.enable = true;
      luks.devices."root" = {
        device = "/dev/disk/by-label/CRYPTONIX";
        keyFile = "/dev/disk/by-partlabel/NIXOS_KEY";
        keyFileSize = 4096;
        keyFileTimeout = 3;
      };
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 80;
    algorithm = "zstd";
  };

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sizes = {
        terminal = 9;
      };
    };
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd niri-session";
          user = "greeter";
        };
      };
    };
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  programs = {
    niri.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  time.timeZone = "America/Sao_Paulo";

  hardware = {
    graphics.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
  networking.networkmanager.enable = true;

  security = {
    sudo-rs.enable = true;
    pam.services.greetd.enableGnomeKeyring = true;
  };
  environment = {
    systemPackages = with pkgs; [
      helix
      wget
      git
      git-lfs
      uutils-coreutils-noprefix
      bluetui
      podman-compose
    ];
    shells = [
      pkgs.nushell
    ];

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  home-manager.users.degartil = {
    imports = [ ../../modules/home.nix ];
  };
  users.users.degartil = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "power"
      "video"
      "audio"
    ];
    shell = pkgs.nushell;
  };

  users.defaultUserShell = pkgs.nushell;

  system.stateVersion = "26.05";
}
