{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      xdg-desktop-portal-gnome
      waypaper
      wl-clipboard-rs
      pavucontrol
      playerctl
      brightnessctl
      pamixer
      xwayland-satellite
    ];
    file.".config/wallpapers" = {
      source = ../home/wallpapers;
      recursive = true;
    };
  };

  programs = {
    rofi = {
      enable = true;
      theme = "gruvbox-dark";
    };
    swaylock.enable = true;
  };
  services = {
    awww.enable = true;
    mako.enable = true;
    swayidle.enable = true;
    polkit-gnome.enable = true;
  };

  xdg = {
    configFile."niri".source = ../home/niri;
    portal = {
      enable = true;
      configPackages = [ pkgs.gnome-session ];
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    };
  };
}
