{ config, pkgs, lib, ... }:
{
  users.users.koenbenne = {
    name = "koenbenne";
    home = "/Users/koenbenne";
    isHidden = false;
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.koenbenne = { lib, ... }: {
      home.stateVersion = "23.05";
      home.packages = pkgs.callPackage ./packages.nix {};
      home.activation = {
        setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          /usr/bin/osascript -e '
            set desktopImage to POSIX file "${config.users.users."koenbenne".home}/.config/nix-darwin/wallpaper.jpg"
            tell application "Finder"
              set desktop picture to desktopImage
            end tell
          '
        '';
      };
      imports = [
        ./programs/fish.nix
        ./programs/kitty.nix
        ./programs/tmux.nix
        ./programs/lazygit.nix
        ./programs/pass.nix
        ./programs/alacritty.nix
        ./services/syncthing.nix
      ];
    };
  };
}
