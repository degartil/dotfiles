{ pkgs, ... }:
{
  home.packages = with pkgs; [
    taplo
    clang
    nil
    nixd
    bash-language-server
    sqlfluff
    rustfmt
    clippy
    rust-analyzer
    lldb
    sqls
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        line-number = "relative";
        soft-wrap.enable = true;
        indent-guides.render = true;
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
