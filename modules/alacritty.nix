{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      mouse.hide_when_typing = true;
      window = {
        title = "Alacritty";
        class = {
          general = "Alacritty";
          instance = "Alacritty";
        };
        dimensions = {
          columns = 200;
          lines = 40;
        };
      };
    };
  };
}
