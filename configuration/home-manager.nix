{ config, pkgs, lib, ... }:
{
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
    };
  };
}
