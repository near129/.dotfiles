{
  programs.ruff = {
    enable = true;
    settings = {
      line-length = 120;
      lint = {
        select = [
          "E"
          "F"
          "UP"
          "B"
          "SIM"
          "I"
          "ARG"
        ];
      };
      cache-dir = "~/.cache/ruff";
    };
  };

}
