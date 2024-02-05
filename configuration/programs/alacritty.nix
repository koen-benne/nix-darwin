{ pkgs, lib, inputs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "buttonless";
        opacity = 0.9;
        padding = {
          x = 5;
          y = 5;
        };
      };
      font = {
        normal = {
          family = "JetBrainsMonoNL Nerd Font Mono";
        };
        size = 15;
      };
      colors = {
        primary = {
          foreground = "#e1dde6";
          background = "#0c1e43";
        };
        cursor = {
          text = "#e1dde6";
          cursor = "#e1dde6";
        };
        normal = {
          black = "#0c1e43";
          red = "#C7669B";
          green = "#00cc00";
          yellow = "#9929CF";
          blue = "#B444C2";
          magenta = "#CC8DB3";
          cyan = "#CFAFCE";
          white = "#e1dde6";
        };
        bright = {
          black = "#9d9aa1";
          red = "#C7669B";
          green = "#00cc00";
          yellow = "#9929CF";
          blue = "#B410C4";
          magenta = "#CC8DB3";
          cyan = "#CFAFCE";
          white = "#e1dde6";
        };
      };
    };
  };
}

