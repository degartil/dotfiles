{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dust
    p7zip
    cargo
    rustc
    rustfmt
    clippy
    rust-analyzer
    fd
    bear
    gemini-cli

    # helix
    taplo
    clang
    nil
    nixd
    bash-language-server
    # docker-language-server
    docker-buildx
    lldb

    # specific things
    cmake
    gnumake
  ];

  home.file.".cargo/config.toml".text = ''
    [target.'cfg(target_os = "linux")']
    linker = "${pkgs.clang}/bin/clang"
    rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold-wrapped}/bin/mold"]
  '';

  programs = {
    lazygit.enable = true;
    lazydocker.enable = true;
    btop.enable = true;
    bat.enable = true;
    eza.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Janson Degartil";
        email = "outragedline@proton.me";
      };
    };
    signing = {
      signByDefault = true;
      key = "734D5FE03B99B29F";
    };
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      "side-by-side" = true;
      navigate = true;
    };
  };

  programs.nushell = {
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
    };

    extraConfig = ''
      def nixos-update [host: string] {
          sudo nix flake update;
          sudo nixos-rebuild switch --flake ~/.nixos#($host)
          git add flake.lock
          git commit -m "Update nixos"
          git push
      }
    '';
  };

  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        show_hidden = true;
      };
    };
  };

  programs.zellij.enable = true;
  home.file.".config/zellij".source = ../home/zellij;

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        line-number = "relative";
        cursorline = true;
        end-of-line-diagnostics = "hint";
        indent-heuristic = "tree-sitter";

        lsp = {
          display-inlay-hints = true;
        };

        file-picker = {
          hidden = false;
          git-global = false;
        };

        soft-wrap = {
          enable = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true;
        };

        inline-diagnostics = {
          cursor-line = "warning";
        };
      };

      keys = {
        normal = {
          z = "move_next_word_start";
          "C-s" = ":write";
          w = "move_next_sub_word_start";
          b = "move_prev_sub_word_start";
          e = "move_next_sub_word_end";
        };

        select = {
          w = "extend_next_sub_word_start";
          b = "extend_prev_sub_word_start";
          e = "extend_next_sub_word_end";
        };

        insert = {
          "C-space" = "completion";
        };
      };
    };

    languages = {
      language = [
        {
          name = "toml";
          formatter = {
            command = "taplo";
            args = [
              "fmt"
              "-"
            ];
          };
          auto-format = true;
        }
        {
          name = "nix";
          formatter = {
            command = "nixfmt";
            args = [ "%sh{pwd}/%{buffer_name}" ];
          };
          auto-format = true;
        }

      ];
      language-server = {
        "rust-analyzer" = {
          config = {
            check = {
              allTargets = true;
            };
            cargo = {
              allFeatures = true;
            };
          };
        };
      };
    };
  };
}
