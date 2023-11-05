{ pkgs, config, home-manager, lib, ... }:

{
  imports = [
   ./dock
  ];

  environment.systemPackages = [
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
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
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
        show-recents = false;
        launchanim = true;
        orientation = "left";
        tilesize = 48;
      };
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;


  # Used for backwards compatibility, please read the changelog before changing.

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  nixpkgs.config.allowUnfree = true;
  # `home-manager` config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.koenbenne = {
      home.stateVersion = "23.05";
      home.packages = pkgs.callPackage ./packages.nix {};
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
      path = "${config.users.users."koenbenne".home}/.local/share/downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];
}
