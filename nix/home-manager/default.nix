{ config, pkgs, ... }:

{
  home = {
  username = "near129";
  homeDirectory = "/Users/near129";
  stateVersion = "24.11"; # Please read the comment before changing.
  packages = with pkgs;
  [
    nil
    nixfmt-rfc-style
  ];
  };
  programs.home-manager.enable = true;
}
