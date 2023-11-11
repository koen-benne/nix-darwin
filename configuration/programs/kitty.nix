{ pkgs, lib, inputs, config, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
      background_opacity 0.9
      hide_window_decorations titlebar-only
      font_family      JetBrainsMonoNL Nerd Font Mono
      font_size        15.0
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
      window_padding_width 5

      foreground   #e1dde6
      background   #0c1e43
      cursor       #e1dde6

      remember_window_size no
      initial_window_width 300c
      initial_window_height 60c

      color0       #0c1e43
      color8       #9d9aa1
      color1       #C7669B
      color9       #C7669B
      color2       #00cc00
      color10      #00cc00
      color3       #9929CF
      color11      #9929CF
      color4       #B444C2
      color12      #B410C4
      color5       #CC8DB3
      color13      #CC8DB3
      color6       #CFAFCE
      color14      #CFAFCE
      color7       #e1dde6
      color15      #e1dde6
    '';
  };
}
