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

        bengal = { name, nodes, pkgs, ... }: {
          imports = [
            ./hosts/${name}/configuration.nix
            ./modules/common
            (import "${home-manager}/nixos")
          ];

          deployment = {
            targetUser = "sammy";
            allowLocalDeployment = true;
          };
        };

        maine-coon = { name, nodes, pkgs, ... }: {
          imports = [
            ./hosts/${name}/configuration.nix
            ./modules/common
            (import "${home-manager}/nixos")
          ];
          deployment = {
            targetHost = "maine-coon";
            allowLocalDeployment = true;
          };
        };
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
