{
  pkgs,
  lib,
  isPrivate,
  ...
}:
{
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };

  # environment.systemPackages = with pkgs; [
  #   zsh
  # ];
  # programs.zsh.enable = true;
  # environment.shells = [
  #   (builtins.trace "sudo chsh -s /run/current-system/sw${pkgs.zsh.shellPath} $USER" pkgs.zsh)
  # ];
  # users.users.near129.shell = pkgs.zsh;

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 7d";
    };
    settings = {
      # Disable auto-optimise-store because of this issue:
      #   https://github.com/NixOS/nix/issues/7273
      # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
      auto-optimise-store = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    hackgen-font
    hackgen-nf-font
    source-han-code-jp
  ];

  system = {
    stateVersion = 5;
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
  networking = lib.mkIf isPrivate {
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
    casks =
      [
        "1password"
        "alacritty"
        "docker"
        "ghostty"
        "google-cloud-sdk"
        "jordanbaird-ice"
        "karabiner-elements"
        "lunar"
        "middleclick"
        "obsidian"
        "raycast"
        "stats"
        "visual-studio-code"
        "wezterm"
        "zed"
        "zen"
      ]
      ++ lib.optionals isPrivate [
        "discord"
        "gimp"
        "google-chrome"
        "google-drive"
        "inkscape"
        "keycastr"
        "obs"
        "slack"
        "tailscale"
      ];
  };
}
