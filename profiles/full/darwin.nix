{ pkgs, ... }: {
  imports = [ ../workstation/darwin.nix ];
  homebrew.brews = [

  ];
  homebrew.casks = [
    "discord"
    "google-drive"
    "keycastr"
    "obs"
    "tailscale-app"
  ];
}
