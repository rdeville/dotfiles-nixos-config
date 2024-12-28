{pkgs, ...}: {
  programs = {
    alacritty = {
      enable = false;
      # package = mkLib.nixGLWrap pkgs.alacritty userCfg;
      package = pkgs.alacritty;
      settings = {
        window = {
          opacity = 0.75;
          title = "Alacritty";
          class = {
            instance = "Alacritty";
            general = "Alacritty";
          };
        };
        scrolling = {
          history = 50000;
          multiplier = 5;
        };
        font = {
          size = 12.0;
          normal = {
            family = "terminal-font";
            style = "Regular";
          };
          bold = {
            style = "Bold";
          };
          bold_italic = {
            style = "Bold Italic";
          };
          italic = {
            style = "Italic";
          };
          # offset = {
          #   x = 0;
          #   y = 1;
          # };
        };
        colors = {
          draw_bold_text_with_bright_colors = true;
          bright = {
            black = "#434758";
            blue = "#9cc4ff";
            cyan = "#a3f7ff";
            green = "#ddffa7";
            magenta = "#e1acff";
            red = "#ff8b92";
            white = "#ffffff";
            yellow = "#ffe585";
          };
          normal = {
            black = "#292d3e";
            blue = "#82aaff";
            cyan = "#89ddff";
            green = "#c3e88d";
            magenta = "#c792ea";
            red = "#f07178";
            white = "#d0d0d0";
            yellow = "#ffcb6b";
          };
          primary = {
            background = "#292d3e";
            foreground = "#d0d0d0";
          };
        };
        keyboard = {
          bindings = [
            {
              action = "Paste";
              key = "V";
              mods = "Control|Shift";
            }
            {
              action = "Copy";
              key = "C";
              mods = "Control|Shift";
            }
            {
              action = "PasteSelection";
              key = "Insert";
              mods = "Shift";
            }
            {
              action = "ResetFontSize";
              key = "Key0";
              mods = "Control";
            }
            {
              action = "IncreaseFontSize";
              key = "Equals";
              mods = "Control";
            }
            {
              action = "IncreaseFontSize";
              key = "Plus";
              mods = "Control";
            }
            {
              action = "DecreaseFontSize";
              key = "Minus";
              mods = "Control";
            }
            {
              action = "ToggleFullscreen";
              key = "F11";
              mods = "None";
            }
            {
              action = "Paste";
              key = "Paste";
              mods = "None";
            }
            {
              action = "Copy";
              key = "Copy";
              mods = "None";
            }
            {
              action = "ClearLogNotice";
              key = "L";
              mods = "Control";
            }
            {
              chars = "\\f";
              key = "L";
              mods = "Control";
            }
            {
              action = "ScrollPageUp";
              key = "PageUp";
              mode = "~Alt";
              mods = "None";
            }
            {
              action = "ScrollPageDown";
              key = "PageDown";
              mode = "~Alt";
              mods = "None";
            }
            {
              action = "ScrollToTop";
              key = "Home";
              mode = "~Alt";
              mods = "Shift";
            }
            {
              action = "ScrollToBottom";
              key = "End";
              mode = "~Alt";
              mods = "Shift";
            }
          ];
        };
      };
    };
  };
}
