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
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 10;
      };
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
    autoEnable = false;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    icons = {
      enable = true;

      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus";
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 9;
        applications = 10;
        desktop = 10;
        popups = 10;
      };
    };

    targets = {
      console.enable = true;
      font-packages.enable = true;
    };
  };
  services = {

    displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/degartil";
    };
    power-profiles-daemon.enable = true;
    upower = {
      enable = true;

      usePercentageForPolicy = true;

      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 15;

      allowRiskyCriticalPowerAction = true;
      criticalPowerAction = "Suspend";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  programs = {
    niri.enable = true;
    dms-shell.enable = true;
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
      podman-compose
      qemu
      virt-manager
    ];
    shells = [
      pkgs.nushell
    ];

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  home-manager = {
    useGlobalPkgs = true;
    users.degartil = {
      imports = [ ../../modules/home.nix ];
    };
  };
  users.users.degartil = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "power"
      "video"
      "audio"
      "libvirtd"
    ];
    shell = pkgs.nushell;
  };

  system.stateVersion = "26.05";
}
