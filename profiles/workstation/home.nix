{ pkgs, ... }: {
  imports = [
    ../default/home.nix
    ./packages.nix
  ];
  programs.codex.package = pkgs.codex;
}
