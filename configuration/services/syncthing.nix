{ pkgs, lib, inputs, config, ... }:
{
  programs.syncthing = {
    enable = true;
  };
}
