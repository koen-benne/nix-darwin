{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, nixpkgs, home-manager }:
    let
      user = "koenbenne";
    in
    {
      darwinConfigurations."MBP-KoenB" = nix-darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          {
            nix-homebrew = {
              enable = true;
              user = "koenbenne";
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };
              mutableTaps = false;
              autoMigrate = true;
            };
          }
          nix-homebrew.darwinModules.nix-homebrew
          ./configuration
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."MBP-KoenB".pkgs;
    };
}
