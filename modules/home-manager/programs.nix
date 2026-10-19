{
  programs.home-manager.enable = true;
  programs.bat = {
    enable = true;
    config.theme = "Nord";
  };
  programs.yazi = {
    enable = true;
    settings.mgr.show_hidden = true;
    enableZshIntegration = false;
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
}
