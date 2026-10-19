{
  config,
  lib,
  pkgs,
  ...
}:
let
  flake = ''(builtins.getFlake "${config.programs.nh.flake}")'';
  system = "${flake}.darwinConfigurations.default";
in
{
  imports = [ ../../profiles/default/home.nix ];

  programs.nh.flake = config.dotfiles.sourceDirectory;
  home.sessionVariables = lib.mapAttrs (_: value: lib.escape [ "\\" "\"" "$" "`" ] value) {
    NIXD_NIXPKGS_EXPR = "import ${flake}.inputs.nixpkgs { system = \"${pkgs.stdenv.hostPlatform.system}\"; }";
    NIXD_SYSTEM_OPTIONS_EXPR = "${system}.options";
    NIXD_HOME_OPTIONS_EXPR = "${system}.options.home-manager.users.type.getSubOptions []";
  };
}
