{
  pkgs,
  primaryUser,
  ...
}:
{
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };

  environment.systemPackages = with pkgs; [
    fish
  ];

  nix = {
    package = pkgs.nix;
    gc.automatic = true;
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    hackgen-font
    hackgen-nf-font
    source-han-code-jp
  ];

  system = {
    stateVersion = 6;
    primaryUser = primaryUser;
    defaults = {
      menuExtraClock.Show24Hour = true;
      dock = {
        autohide = true;
        show-recents = false;
      };
      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      trackpad = {
        TrackpadRightClick = true;
        FirstClickThreshold = 1;
      };
      screencapture = {
        location = "~/Pictures/Screenshots"; # If the location set above does not exist, it will be saved to the desktop
      };
      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;
        AppleInterfaceStyle = "Dark";

        InitialKeyRepeat = 15;
        KeyRepeat = 2;

        "com.apple.trackpad.scaling" = 3.0;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
      WindowManager = {
        EnableTiledWindowMargins = false;
      };
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.spaces" = {
          "spans-displays" = 0;
        };
        "com.microsoft.VSCode".ApplePressAndHoldEnabled = false;
        "com.microsoft.VSCodeInsiders".ApplePressAndHoldEnabled = false;
      };
    };
  };
  networking = {
    knownNetworkServices = [
      "Wi-Fi"
      "Ethernet Adaptor"
      "Thunderbolt Ethernet"
    ];
    dns = [
      "8.8.8.8"
      "8.8.4.4"
      "2001:4860:4860::8888"
      "2001:4860:4860::8844"
    ];
  };
  homebrew = {
    # https://brew.sh/
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    taps = [
      "nikitabobko/tap"
    ];
    casks = [
      "1password"
      "aerospace"
      "alacritty"
      "arc"
      "docker-desktop"
      "firefox"
      "ghostty"
      "jordanbaird-ice"
      "karabiner-elements"
      "lm-studio"
      "middleclick"
      "obsidian"
      "ollama-app"
      "visual-studio-code"
      "wezterm"
      "zed"
      "zen"
    ];
  };
}
