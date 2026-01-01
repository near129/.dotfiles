{
  description = "Nix configuration for macOS with nix-darwin and home-manager";

  inputs = {
    self.submodules = true;
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ ... }:
    {
      darwinConfigurations = {
        napoli25 = import ./nix/hosts/napoli25.nix { inherit inputs; };
      };
    };
}
