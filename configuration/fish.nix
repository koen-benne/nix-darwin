{ pkgs, lib, inputs, config, ... }:
{
  programs.fish = {
    enable = true;
    shellInit = ''
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
      end
    '';
    interactiveShellInit = ''
      set -U Z_CMD "j"
      set -gx DIRENV_LOG_FORMAT ""
    '';
    shellAliases = {
      vim = "nvim";
      lg = "lazygit";
      ll = "ls -lah";
      shell = "export NIXPKGS_ALLOW_INSECURE=1 && nix shell --impure";
      to = "turbotmux open";
      tc = "turbotmux close";
      tp = "turbotmux project";
      tn = "turbotmux new";
      darwin-switch = "darwin-rebuild switch --flake ~/.config/nix-darwin";
    };
  };
}
