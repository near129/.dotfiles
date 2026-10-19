{ ... }:
{
  imports = [ ../../profiles/default/darwin.nix ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = "near129";
  system.stateVersion = 7;
  users.users.near129.home = "/Users/near129";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = false;
    users.near129 = {
      imports = [ ./home.nix ];
      home.stateVersion = "26.05";
    };
  };
}
