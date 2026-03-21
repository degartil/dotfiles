{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dust
    p7zip
    cargo
    cargo-watch
    rustc
    rustfmt
    clippy
    rust-analyzer
    fd
    ripgrep
    fzf
    bear
    gemini-cli

    sqls
    lldb
    cmake
    gnumake
  ];

  home.file = {
    ".config/zellij".source = ../home/zellij;
    ".cargo/config.toml".text = ''
      [target.'cfg(target_os = "linux")']
      linker = "${pkgs.clang}/bin/clang"
      rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]
    '';
  };

  programs = {
    lazygit.enable = true;
    zellij.enable = true;
    btop.enable = true;
    bat.enable = true;
    eza.enable = true;

    git = {
      enable = true;
      settings = {
        user = {
          name = "Degartil";
          email = "degartil@proton.me";
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
      '';
      shellAliases = {
        la = "ls -la";
        cat = "bat";
        lg = "lazygit";
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
}
