{ self, config, pkgs, lib, overlays, ... }:
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
    users.koenbenne = { lib, overlays, ... }: {
      nixpkgs.overlays = overlays;
      home.stateVersion = "23.11";
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
        ./programs/neovim.nix
        ./programs/alacritty.nix
        ./services/syncthing.nix
      ];
    };
  };
}
