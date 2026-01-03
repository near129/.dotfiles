{
  ...
}:
let
  macosGitignorePath = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Global/macOS.gitignore";
    sha256 = "1bmxv9qm6mv7m8kqrggc6ddzi508257q9ryrm6ngyj0nli06caqs";
  };
  macosGitignore = builtins.readFile macosGitignorePath;
in
{
  programs.git = {
    enable = true;
    signing = {
      signByDefault = true;
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC+0IqYbnBD7Cjh+DvaSucRW02cbc5i4peT86vfYMDH1";
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
    ignores = [
      ".op.env" # 1Password environment variables
      ".serena"
      ".claude/settings.local.json"
      macosGitignore
    ];
    settings = {
      user = {
        name = "near129";
        email = "56579877+near129@users.noreply.github.com";
      };
      alias = {
        pushf = "push --force-with-lease --force-if-includes";
        tree = "log --graph --pretty=format:'%C(auto)%h %d %s %C(blue)(%cr) %C(green)<%an>'";
        wls = "worktree list";
      };
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
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
