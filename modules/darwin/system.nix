{
  pkgs,
  ...
}:
{
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };

  # Roots chaining to the compromised eMudhra intermediates: https://emudhra.we-have-a-problem.com/
  security.pki.caCertificateBlacklist = [
    "Comodo AAA Services root"
    "emSign ECC Root CA - G3"
  ];

  environment.systemPackages = with pkgs; [
    fish
  ];

  system = {
    startup.chime = false;
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
}
