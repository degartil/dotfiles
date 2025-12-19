{ pkgs, ... }:

{
  imports = [
    ./devenv.nix
    ./alacritty.nix
  ];

  home.packages = with pkgs; [
    xdg-desktop-portal-gnome
    pavucontrol
    rofi
    alacritty
    wl-clipboard
    swww
    git-lfs
    networkmanagerapplet
    fastfetch
    waypaper
    grimblast
    playerctl

    obs-studio
    ueberzugpp
    telegram-desktop
    zathura

    # eww
    brightnessctl
    socat
    jq
    inotify-tools
    pamixer

    niri
    xwayland-satellite
  ];

  stylix.targets = {
    zellij.enable = false;
    helix.enable = false;
  };

  home.file.".config/wallpapers" = {
    source = ../home/wallpapers;
    recursive = true;
  };

  home.sessionPath = [
    "~/.local/bin"
    "~/.cargo/bin"
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  xdg.configFile."niri".source = ../home/niri;
  xdg.portal = {
    enable = true;
    configPackages = [ pkgs.gnome-session ];
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
  programs.swaylock.enable = true;
  services.mako.enable = true;
  services.swayidle.enable = true;
  services.polkit-gnome.enable = true;

  programs.eww = {
    enable = true;
    configDir = ../home/eww;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  services.syncthing.enable = true;

  home.stateVersion = "25.05";
}
