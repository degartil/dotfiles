{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-label/CRYPTONIX";
    keyFile = "/dev/disk/by-partlabel/NIXOS_KEY";
    keyFileSize = 4096;
    keyFileTimeout = 3;
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
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.niri}/bin/niri-session";
        user = "degartil";
      };
    };
  };
  programs.niri.enable = true;

  time.timeZone = "America/Sao_Paulo";

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  networking.networkmanager.enable = true;

  security.sudo-rs.enable = true;
  environment.systemPackages = with pkgs; [
    helix
    wget
    git
    git-lfs
    uutils-coreutils-noprefix
    bluetui
  ];

  environment.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
  virtualisation.docker.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;

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

  system.stateVersion = "25.05";
}
