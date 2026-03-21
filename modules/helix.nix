{ pkgs, ... }:
{
  home.packages = with pkgs; [
    taplo
    clang
    nil
    nixd
    bash-language-server
    sqlfluff
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        line-number = "relative";
        cursorline = true;
        end-of-line-diagnostics = "hint";
        file-picker = {
          hidden = false;
          git-global = false;
        };
        soft-wrap.enable = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides.render = true;

        inline-diagnostics.cursor-line = "warning";
      };

      keys = {
        normal = {
          z = "move_prev_word_start";
          "C-s" = ":write";
          w = "move_next_sub_word_start";
          b = "move_prev_sub_word_start";
          e = "move_next_word_end";
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

        {
          name = "sql";
          language-servers = [ "sqls" ];
          formatter = {
            command = "sqlfluff";
            args = [
              "format"
              "-"
            ];
          };
          auto-format = true;
        }
      ];
      language-server = {
        sqls = {
          command = "sqls";
        };
        "rust-analyzer" = {
          config = {
            check = {
              command = "clippy";
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
