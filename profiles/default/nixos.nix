{ pkgs, ... }: {
  imports = [ ../../modules/shared/nix.nix ];
  environment.systemPackages = [ pkgs.fish ];
}
