{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , ...
    }:
    let
      system = "x86_64-linux";
      mkHost = hostname: {
        imports = [
          ./hosts/${hostname}/configuration.nix
          ./modules/common
          (import "${home-manager}/nixos")
        ];

        deployment = {
          targetUser = "root";
          targetHost = hostname;
          allowLocalDeployment = true;
        };
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ ];
          };
        };

        bengal = mkHost "bengal";
      };
      nixosConfigurations.test = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/test-vm/configuration.nix
          (import "${home-manager}/nixos")
        ];
      };
    };
}
