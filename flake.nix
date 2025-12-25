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
      darwinConfigurations."near129" = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [ ./nix/nix-darwin ];
        specialArgs = {
          isPrivate = true;
        };
      };
      homeConfigurations."near129" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./nix/home-manager ];
        extraSpecialArgs = {
          username = "near129";
        };
      };
    };
}
