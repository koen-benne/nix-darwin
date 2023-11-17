{ pkgs, lib, inputs, config, ... }:
{
  services.syncthing = {
    enable = true;
  };
}
