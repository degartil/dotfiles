{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
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
      luks.devices."root" = {
        device = "/dev/disk/by-label/CRYPTONIX";
        keyFile = "/dev/disk/by-partlabel/NIXOS_KEY";
        keyFileSize = 4096;
        keyFileTimeout = 3;
      };
    };
  };

  systemd.services.battery-charge-limit = {
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold
    '';
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
    journald.settings.Journal.SystemMaxUse = "1G";
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
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

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
      colloid-icon-theme
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
    libvirtd.enable = false;
    spiceUSBRedirection.enable = true;
  };
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
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
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;

  system.stateVersion = "26.11";
}
