{ pkgs, ... }: {
  imports = [
    ../../modules/shared/nix.nix
    ../../modules/shared/nh.nix
  ];
  environment.systemPackages = [ pkgs.fish ];
}
