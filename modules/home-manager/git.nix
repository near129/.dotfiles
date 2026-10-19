{
  lib,
  pkgs,
  ...
}:
let
  macosGitignorePath = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Global/macOS.gitignore";
    sha256 = "0wlwv586qv4ln3hgg8hl5cl1a67l5gpzcwahbyzs46lcabci8nvz";
  };
  macosGitignore = builtins.readFile macosGitignorePath;
in
{
  programs.git = {
    enable = true;
    ignores = [
      ".op.env" # 1Password environment variables
      ".serena"
      ".claude/settings.local.json"
      ".claude/worktrees"
      ".worktree"
      ".temp"
      ".playwright*/"
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [ macosGitignore ];
    settings = {
      alias = {
        pushf = "push --force-with-lease --force-if-includes";
        tree = "log --graph --pretty=format:'%C(auto)%h %d %s %C(blue)(%cr) %C(green)<%an>'";
        wls = "worktree list";
      };
      init.defaultBranch = "main";
      merge = {
        conflictstyle = "diff3";
        tool = "nvimdiff";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "side-by-side line-numbers";
      syntaxTheme = "Nord";
    };
  };
}
