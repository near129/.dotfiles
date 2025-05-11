{
  programs.ruff = {
    enable = true;
    settings = {
      line-length = 100;
      lint = {
        select = [
          "E"
          "F"
          "UP"
          "B"
          "SIM"
          "I"
        ];
      };
    };
  };

}
