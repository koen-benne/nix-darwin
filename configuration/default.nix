{ pkgs, config, home-manager, lib, ... }:

{
  imports = [
   ./dock
   ./yabai.nix
   ./skhd.nix
   ./fish.nix
   ./kitty.nix
  ];

  environment.systemPackages = [
    # home manager has issues with adding apps
    pkgs.kitty
  ];

  users.users.koenbenne = {
    name = "koenbenne";
    home = "/Users/koenbenne";
    isHidden = false;
    shell = pkgs.fish;
  };

  homebrew.enable = true;
  homebrew.casks = pkgs.callPackage ./casks.nix {};

  # homebrew.masApps = {
  #   "1password" = 1333542190;
  # };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nixUnstable;
    settings.trusted-users = [ "@admin" "koenbenne" ];
    settings.experimental-features = "nix-command flakes";
    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };
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

  programs.bash.enable = true;
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  nixpkgs.config.allowUnfree = true;
  # `home-manager` config
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
