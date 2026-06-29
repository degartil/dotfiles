{ pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./helix.nix
    ./niri.nix
  ];

  stylix.enableReleaseChecks = false;

  stylix.targets = {
    zellij.enable = false;
    helix.enable = false;
    rofi.enable = false;
  };

  home = {
    enableNixpkgsReleaseCheck = false;
    packages = with pkgs; [
      git-lfs
      fastfetch
      onefetch

      cargo-watch
      rustc
      cargo

      obs-studio
      telegram-desktop
      zathura

      cmake
      gnumake

      dust
      p7zip
      fd
      ripgrep
      fzf
      bear
      kdePackages.kdenlive
    ];

    file = {
      ".config/zellij".source = ../home/zellij;
      ".cargo/config.toml".text = ''
        [target.'cfg(target_os = "linux")']
        linker = "${pkgs.clang}/bin/clang"
        rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]
      '';
    };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  programs = {
    zellij.enable = true;
    btop.enable = true;
    bat.enable = true;
    eza.enable = true;
    thunderbird.enable = true;
    git = {
      enable = true;
      settings = {
        user = {
          name = "Degartil";
          email = "degartil@gmail.com";
        };
      };
      signing = {
        signByDefault = true;
        key = "734D5FE03B99B29F";
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        "side-by-side" = true;
        navigate = true;
      };
    };

    nushell = {
      enable = true;
      settings = {
        show_banner = false;
        buffer_editor = "hx";
      };
      envFile.text = ''
        $env.PROMPT_COMMAND = { || $"($env.PWD | path basename)" }
        $env.PROMPT_COMMAND_RIGHT = ""
        $env.EDITOR = "hx"
        $env.VISUAL = "hx"
        def nr [
            package: string
            ...rest
        ] {
            let flake_ref = if ($package | str contains "#") {
                $package
            } else {
                $"nixpkgs#($package)"
            }    
            nix run $flake_ref ...$rest
        }
      '';
      shellAliases = {
        la = "ls -la";
        cat = "bat";
        mkd = "mkdir";
        zj = "zellij";
        nd = "nix develop -c nu";
      };
    };

    yazi = {
      enable = true;
      settings = {
        mgr = {
          show_hidden = true;
        };
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.stateVersion = "26.05";
}
