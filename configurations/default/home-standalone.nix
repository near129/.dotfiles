{
  config,
  lib,
  pkgs,
  ...
}:
let
  flake = ''(builtins.getFlake "${config.programs.nh.flake}")'';
in
{
  imports = [ ../../profiles/default/home.nix ];

  home = {
    username = "near129";
    homeDirectory = "/Users/near129";
    stateVersion = "26.05";
    packages = [ pkgs.fish ];
    sessionVariables = lib.mapAttrs (_: value: lib.escape [ "\\" "\"" "$" "`" ] value) {
      NIXD_NIXPKGS_EXPR = "import ${flake}.inputs.nixpkgs { system = \"${pkgs.stdenv.hostPlatform.system}\"; }";
      NIXD_HOME_OPTIONS_EXPR = "${flake}.homeConfigurations.near129.options";
    };
  };
  programs.nh.flake = config.dotfiles.sourceDirectory;
}
