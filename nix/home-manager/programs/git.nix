{
  username,
  email,
  ...
}:
let
  macosGitignoreMacosPath = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Global/macOS.gitignore";
    sha256 = "0xjnwcd84qdf0bmmxjszszh11kmi8hw3n4wqsaywf9l7kkigda6k";
  };
  macosGitignoreMacos = builtins.readFile macosGitignoreMacosPath;
in
{
  programs.git = {
    enable = true;
    userName = username;
    userEmail = email;
    signing = {
      signByDefault = true;
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC+0IqYbnBD7Cjh+DvaSucRW02cbc5i4peT86vfYMDH1";
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
    ignores = [
      macosGitignoreMacos
    ];
    aliases = {
      pushf = "push --force-with-lease";
      tree = "log --graph --pretty=format:'%C(auto)%h %d %s %C(blue)(%cr) %C(green)<%an>'";
    };
    extraConfig = {
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
    };
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers";
        syntaxTheme = "Nord";
      };
    };
  };

}
