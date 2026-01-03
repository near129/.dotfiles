{
  programs.fzf = {
    enable = true;
    defaultCommand = "(fd --hidden --exclude .git -d 5 && fd --hidden --exclude .git --min-depth 6)";
    fileWidgetCommand = "(fd --hidden --exclude .git -d 5 && fd --hidden --exclude .git --min-depth 6)";
    fileWidgetOptions = [
      "--select-1"
      "--exit-0"
      "--preview '(bat  --color=always --style=header,grid --line-range :100 {} || exa -T -L 2) 2>/dev/null'"
    ];
    colors = {
      "fg" = "#d8dee9";
      "bg" = "#2e3440";
      "hl" = "#a3be8c";
      "fg+" = "#d8dee9";
      "bg+" = "#434c5e";
      "hl+" = "#a3be8c";
      "pointer" = "#bf616a";
      "info" = "#4c566a";
      "spinner" = "#4c566a";
      "header" = "#4c566a";
      "prompt" = "#81a1c1";
      "marker" = "#ebcb8b";
    };
  };
}
