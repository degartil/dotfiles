{ lib, pkgs, ... }:

let
  exe = lib.getExe;
in
{
  home = {
    packages = with pkgs; [
      wl-clipboard-rs
    ];

    file.".config/wallpapers" = {
      source = ../home/wallpapers;
      recursive = true;
    };
  };

  wayland.windowManager.niri = {
    enable = true;

    # NixOS programs.niri already owns these.
    systemd.enable = false;
    portalPackage = null;

    settings = {
      environment.ELECTRON_OZONE_PLATFORM_HINT = "auto";

      input = {
        keyboard.xkb = {
          layout = "br";
          variant = "abnt2";
        };

        touchpad = {
          tap = { };
          dwt = { };
          scroll-method = "two-finger";
        };

        warp-mouse-to-focus = { };
      };

      layout = {
        gaps = 10;
        center-focused-column = "never";

        preset-column-widths._children = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        default-column-width = { };
        background-color = "transparent";

        focus-ring = {
          width = 2;
        };
      };

      prefer-no-csd = { };

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      window-rule = {
        geometry-corner-radius = 10;
        clip-to-geometry = true;
      };

      binds = {
        "Mod+Return".spawn = [
          (exe pkgs.alacritty)
        ];

        "Mod+N".spawn = [
          "dms"
          "ipc"
          "call"
          "notepad"
          "toggle"
        ];

        "Mod+D".spawn = [
          "dms"
          "ipc"
          "call"
          "spotlight"
          "toggle"
        ];

        "Super+Alt+L".spawn = [
          "dms"
          "ipc"
          "call"
          "lock"
          "lockAndOutputsOff"
        ];

        "XF86AudioRaiseVolume".spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "increment"
          "10"
        ];

        "XF86AudioLowerVolume".spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "decrement"
          "10"
        ];

        "XF86AudioMute".spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "mute"
        ];

        "XF86AudioMicMute".spawn = [
          "dms"
          "ipc"
          "call"
          "mic"
          "mute"
        ];

        "XF86AudioPlay".spawn = [
          "dms"
          "ipc"
          "call"
          "mpris"
          "playPause"
        ];

        "XF86AudioNext".spawn = [
          "dms"
          "ipc"
          "call"
          "mpris"
          "next"
        ];

        "XF86AudioPrev".spawn = [
          "dms"
          "ipc"
          "call"
          "mpris"
          "previous"
        ];

        "XF86MonBrightnessUp".spawn = [
          "dms"
          "ipc"
          "call"
          "brightness"
          "increment"
          "10"
        ];

        "XF86MonBrightnessDown".spawn = [
          "dms"
          "ipc"
          "call"
          "brightness"
          "decrement"
          "10"
        ];

        "Mod+O" = {
          _props.repeat = false;
          toggle-overview = { };
        };

        "Mod+B".spawn = [
          (exe pkgs.brave-origin)
        ];

        "Mod+T".spawn = [
          (exe pkgs.telegram-desktop)
        ];

        "Mod+Shift+Q" = {
          _props.repeat = false;
          close-window = { };
        };

        "Mod+Left".focus-column-left = { };
        "Mod+Down".focus-window-down = { };
        "Mod+Up".focus-window-up = { };
        "Mod+Right".focus-column-right = { };

        "Mod+H".focus-column-left = { };
        "Mod+J".focus-window-down = { };
        "Mod+K".focus-window-up = { };
        "Mod+L".focus-column-right = { };

        "Mod+Ctrl+Left".move-column-left = { };
        "Mod+Ctrl+Down".move-window-down = { };
        "Mod+Ctrl+Up".move-window-up = { };
        "Mod+Ctrl+Right".move-column-right = { };

        "Mod+Ctrl+H".move-column-left = { };
        "Mod+Ctrl+J".move-window-down = { };
        "Mod+Ctrl+K".move-window-up = { };
        "Mod+Ctrl+L".move-column-right = { };

        "Mod+Shift+Left".focus-monitor-left = { };
        "Mod+Shift+Down".focus-monitor-down = { };
        "Mod+Shift+Up".focus-monitor-up = { };
        "Mod+Shift+Right".focus-monitor-right = { };

        "Mod+Shift+H".focus-monitor-left = { };
        "Mod+Shift+J".focus-monitor-down = { };
        "Mod+Shift+K".focus-monitor-up = { };
        "Mod+Shift+L".focus-monitor-right = { };

        "Mod+Page_Down".focus-workspace-down = { };
        "Mod+Page_Up".focus-workspace-up = { };
        "Mod+U".focus-workspace-down = { };
        "Mod+I".focus-workspace-up = { };

        "Mod+Ctrl+Page_Down".move-column-to-workspace-down = { };
        "Mod+Ctrl+Page_Up".move-column-to-workspace-up = { };
        "Mod+Ctrl+U".move-column-to-workspace-down = { };
        "Mod+Ctrl+I".move-column-to-workspace-up = { };

        "Mod+Shift+U".move-workspace-down = { };
        "Mod+Shift+I".move-workspace-up = { };

        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;

        "Mod+Shift+1".move-column-to-workspace = 1;
        "Mod+Shift+2".move-column-to-workspace = 2;
        "Mod+Shift+3".move-column-to-workspace = 3;
        "Mod+Shift+4".move-column-to-workspace = 4;
        "Mod+Shift+5".move-column-to-workspace = 5;
        "Mod+Shift+6".move-column-to-workspace = 6;
        "Mod+Shift+7".move-column-to-workspace = 7;
        "Mod+Shift+8".move-column-to-workspace = 8;
        "Mod+Shift+9".move-column-to-workspace = 9;

        "Mod+Tab".focus-workspace-previous = { };

        "Mod+BracketLeft".consume-or-expel-window-left = { };
        "Mod+BracketRight".consume-or-expel-window-right = { };

        "Mod+R".switch-preset-column-width = { };
        "Mod+Shift+R".switch-preset-window-height = { };
        "Mod+Ctrl+R".reset-window-height = { };

        "Mod+F".maximize-column = { };
        "Mod+Shift+F".fullscreen-window = { };
        "Mod+Ctrl+F".expand-column-to-available-width = { };

        "Mod+C".center-column = { };
        "Mod+Ctrl+C".center-visible-columns = { };

        "Mod+Minus".set-column-width = "-10%";
        "Mod+Equal".set-column-width = "+10%";

        "Mod+Shift+Minus".set-window-height = "-10%";
        "Mod+Shift+Equal".set-window-height = "+10%";

        "Mod+V".toggle-window-floating = { };
        "Mod+Shift+V".switch-focus-between-floating-and-tiling = { };

        "Mod+W".toggle-column-tabbed-display = { };

        "Print".screenshot = { };
        "Ctrl+Print".screenshot-screen = { };
        "Alt+Print".screenshot-window = { };

        "Mod+Escape" = {
          _props.allow-inhibiting = false;
          toggle-keyboard-shortcuts-inhibit = { };
        };

        "Mod+Shift+E".quit = { };
        "Ctrl+Alt+Delete".quit = { };

        "Mod+Shift+P".power-off-monitors = { };
      };

      gestures.hot-corners.off = { };

      layer-rule = {
        match._props.namespace = "^quickshell$";
        place-within-backdrop = true;
      };

      overview.backdrop-color = "transparent";
    };

    extraConfig = ''
      include optional=true "dms/colors.kdl"
      include optional=true "dms/layout.kdl"
      include optional=true "dms/wpblur.kdl"
      include optional=true "dms/windowrule.kdl"
    '';
  };
}
