{ inputs, system }:
let
  inherit (inputs)
    self
    nixpkgs
    home-manager
    nix-darwin
    ;
  inherit (nixpkgs) lib;
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  darwin = pkgs.stdenv.hostPlatform.isDarwin;
  names =
    if darwin then
      [
        "default"
        "workstation"
        "full"
      ]
    else
      [ "default" ];
  username = "profile-check";
  homeDirectory = if darwin then "/Users/${username}" else "/home/${username}";
  fixture =
    profile:
    let
      modules = [
        (if darwin then self.darwinModules.${profile} else self.nixosModules.default)
        (if darwin then home-manager.darwinModules.home-manager else home-manager.nixosModules.home-manager)
        {
          nixpkgs.hostPlatform = system;
          users.users.${username}.home = homeDirectory;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = false;
            users.${username} = {
              imports = [ self.homeModules.${profile} ];
              home.stateVersion = "26.05";
            };
          };
        }
        (
          if darwin then
            {
              system.primaryUser = username;
              system.stateVersion = 7;
            }
          else
            {
              system.stateVersion = "26.05";
              users.users.${username}.isNormalUser = true;
              boot.loader.grub.enable = false;
              fileSystems."/" = {
                device = "none";
                fsType = "tmpfs";
              };
            }
        )
      ];
      os = (if darwin then nix-darwin.lib.darwinSystem else lib.nixosSystem) { inherit modules; };
    in
    {
      inherit os;
      home = os.config.home-manager.users.${username};
    };
  results = map (
    profile:
    let
      evaluated = fixture profile;
    in
    builtins.seq evaluated.os.config.system.build.toplevel.drvPath (
      builtins.seq evaluated.home.home.activationPackage.drvPath profile
    )
  ) names;
in
builtins.seq (if darwin then self.darwinConfigurations.default.system.drvPath else null) (
  builtins.seq (if darwin then self.homeConfigurations.near129.activationPackage.drvPath else null) (
    builtins.deepSeq results (pkgs.writeText "dotfiles-profile-check" (builtins.toJSON results))
  )
)
