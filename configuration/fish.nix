{ pkgs, lib, inputs, config, ... }:
let
  programs = ./programs;
in
{
  programs.fish = {
    enable = true;
    shellInit = ''
      if [ -f ${programs}/config.fish ]; then
        source ${programs}/config.fish
      fi
    '';
  };
}
