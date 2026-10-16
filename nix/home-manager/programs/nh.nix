{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      # On Darwin a string is passed to nh as a single argument, so use a list.
      extraArgs = [
        "--keep-since"
        "30d"
        "--keep-one"
      ];
    };
  };
}
