{ self, pkgs, config, home-manager, lib, overlays, ... }:

{
  imports = [
    ./dock
    ./home-manager.nix

    # set up programs globally
    # usually better to set up per user in home manager
    # yabai and skhd need to be set up globally for some reason
    ./services/yabai.nix
    ./services/skhd.nix
  ];

  # allows me to do nix shell node#[version] better than with nixpkgs
  # its old tho
  nix.registry."node".to = {
    type = "github";
    owner = "andyrichardson";
    repo = "nix-node";
  };

  environment.systemPackages = [
    # place to add programs system wide
  ];

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    # taps = pkgs.callPackage ./formulas.nix {};
    # masApps = {
    #   "1password" = 1333542190;
    # };
  };


  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nixUnstable;
    settings = {
      trusted-users = [ "@admin" "koenbenne" ];
      experimental-features = "nix-command flakes";
      substituters = [ "https://cache.nixos.org/" "https://nix-node.cachix.org/?priority=10" "https://nix-community.cachix.org/?priority=10" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "nix-node.cachix.org-1:2YOHGtGxa8VrFiWAkYnYlcoQ0sSu+AqCniSfNagzm60="];
    };
    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };
  };

  # Necessary for settings environment variables n shi.
  programs = {
    bash.enable = true;
    zsh.enable = true;
    fish.enable = true;
  };

  system = {
    stateVersion = 4;
    checks.verifyNixPath = false;
    defaults = {
      LaunchServices = {
        LSQuarantine = false;
      };
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        AppleFontSmoothing = 1;
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        _HIHideMenuBar = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.swipescrolldirection" = true;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      dock = {
        autohide = true;
        showhidden = true;
        mru-spaces = false;
        show-recents = false;
        launchanim = true;
        orientation = "left";
        tilesize = 48;
      };
    };
  };

  nixpkgs = {
    hostPlatform = "x86_64-darwin";
    config.allowUnfree = true;
  };

  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Slack.app/"; }
    { path = "${pkgs.kitty}/Applications/Kitty.app/"; }
    { path = "/System/Applications/News.app/"; }
    { path = "/System/Applications/Home.app/"; }
    {
      path = "${config.users.users."koenbenne".home}/.local/share/";
      section = "others";
      options = "--sort name --view grid --display folder";
    }
    {
      path = "${config.users.users."koenbenne".home}/Downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];
}
