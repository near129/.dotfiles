{ inputs }:
let
  inherit (inputs) nixpkgs home-manager nix-darwin;
  username = "near129";
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
nix-darwin.lib.darwinSystem {
  inherit pkgs;
  specialArgs = {
    primaryUser = username;
  };
  modules = [
    (
      { ... }:
      {
        users.users."${username}".home = "/Users/${username}";
      }
    )
    ../nix-darwin
    ../nix-darwin/extra.nix
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        # TODO: It seems that it will be true by default in the future, but currently if set to true, packages installed with nix are not in the PATH in fish, so consider countermeasures.
        useUserPackages = false;
        users.${username} = ../home-manager;
        extraSpecialArgs = {
          inherit username; # TODO: multiple users support
        };
      };
    }
  ];
}
