{ pkgs, ... }: {
  imports = [ ../workstation/darwin.nix ];
  homebrew.brews = [

  ];
  homebrew.casks = [
    "chrome-remote-desktop-host"
    "discord"
    "google-drive"
    "keycastr"
    "obs"
    "tailscale-app"
  ];
}
