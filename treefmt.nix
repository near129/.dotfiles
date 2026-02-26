{ ... }:
{
  # Used to find the project root
  projectRootFile = "flake.nix";
  programs.fish_indent.enable = true;
  programs.nixfmt.enable = true;
  programs.oxfmt.enable = true;
  programs.stylua.enable = true;
  programs.taplo.enable = true;
  settings.formatter.oxfmt.excludes = [
    ".config/nvim/lazy-lock.json"
  ];
}
