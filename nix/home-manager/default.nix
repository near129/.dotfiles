{ config, pkgs, ... }:
let
username = "near129";
in
{
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.11"; # Please read the comment before changing.
    packages = with pkgs; [
      git
      nil
      nixfmt-rfc-style
      zsh
    ];
  };
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initExtraBeforeCompInit = builtins.readFile ../../.config/zsh/.zshrc;
    profileExtra = builtins.readFile ../../.config/zsh/.zprofile;
    envExtra = builtins.readFile ../../.config/zsh/.zshenv;
  };
  programs.git = {
    enable = true;
    userName = username;
    userEmail = "56579877+near129@users.noreply.github.com";
  };
  home.file.".config/git/ignore".source = ../../.config/git/ignore;
}
