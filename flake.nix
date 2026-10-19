{
  description = "Reusable dotfiles modules and default, workstation, and full profiles";

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
    treefmt-nix.url = "github:numtide/treefmt-nix";
    systems.url = "github:nix-systems/default";
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      treefmt-nix,
      systems,
      ...
    }:
    let
      # Nixpkgs 26.11 no longer supports Intel macOS.
      eachSystem = nixpkgs.lib.genAttrs (
        builtins.filter (system: system != "x86_64-darwin") (import systems)
      );
      treefmtEval = eachSystem (
        system: treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix
      );
    in
    {
      darwinConfigurations.default = nix-darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          ./configurations/default/darwin.nix
        ];
      };
      homeConfigurations.near129 = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
        modules = [ ./configurations/default/home-standalone.nix ];
      };
      formatter = eachSystem (system: treefmtEval.${system}.config.build.wrapper);
      checks = eachSystem (system: {
        formatting = treefmtEval.${system}.config.build.check self;
        profiles = import ./tests/profiles.nix { inherit inputs system; };
      });
      homeModules = {
        default = ./profiles/default/home.nix;
        workstation = ./profiles/workstation/home.nix;
        full = ./profiles/full/home.nix;
        files = ./modules/home-manager/files.nix;
        fish = ./modules/home-manager/fish.nix;
        git = ./modules/home-manager/git.nix;
        zsh = ./modules/home-manager/zsh.nix;
        codex = ./modules/home-manager/codex.nix;
        fzf = ./modules/home-manager/fzf.nix;
        nh = ./modules/home-manager/nh.nix;
        ruff = ./modules/home-manager/ruff.nix;
      };
      darwinModules = {
        default = ./profiles/default/darwin.nix;
        workstation = ./profiles/workstation/darwin.nix;
        full = ./profiles/full/darwin.nix;
      };
      nixosModules.default = ./profiles/default/nixos.nix;
    };
}
