{
  programs.home-manager.enable = true;
  programs.bat = {
    enable = true;
    config.theme = "Nord";
  };
  programs.yazi = {
    enable = true;
    settings.manager.show_hidden = true;
    enableZshIntegration = false;
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
}
