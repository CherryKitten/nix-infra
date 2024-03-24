{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      mkHost = hostname: graphical: {
        imports = [
          ./hosts/${hostname}/configuration.nix
          ./modules/common
          (import "${home-manager}/nixos")
          (if graphical then ./modules/graphical else null)
        ];

        deployment = {
          targetUser = "root";
          targetHost = hostname;
          allowLocalDeployment = true;
        };
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ ];
          };
        };

        bengal = mkHost "bengal" true;

      };
    };
}
