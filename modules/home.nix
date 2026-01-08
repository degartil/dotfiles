{ pkgs, ... }:

{
  imports = [
    ./core.nix
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
    fastfetch
    onefetch
    waypaper
    grimblast
    playerctl

    obs-studio
    ueberzugpp
    telegram-desktop
    zathura

    brightnessctl
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
