{ config, pkgs, ... }:
let
username = "near129";
email = "56579877+near129@users.noreply.github.com";
dotConfigDir = ../../.config;
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
    initExtraBeforeCompInit = builtins.readFile dotConfigDir + .config/zsh/.zshrc;
    profileExtra = builtins.readFile dotConfigDir + .config/zsh/.zprofile;
    envExtra = builtins.readFile dotConfigDir + .config/zsh/.zshenv;
  };
  programs.git = {
    enable = true;
    userName = username;
    userEmail = email;
  };
  home.file.".config/git/ignore".source = dotConfigDir + .config/git/ignore;
}
