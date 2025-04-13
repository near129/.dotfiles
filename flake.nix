{
  description = "Example nix-darwin system flake";

  inputs = {
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
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#MacBook-Air
      darwinConfigurations."MacBook-Air" = nix-darwin.lib.darwinSystem {
        modules = [ ./nix/nix-darwin/default.nix ];
      };
      homeConfigurations."near129@MacBook-Air" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./nix/home-manager/default.nix ];
      };
    };
}
