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
      mkHost = { hostname, user ? "sammy" }: {

        imports = [
          ./hosts/${hostname}/configuration.nix
          ./modules
          (import "${home-manager}/nixos")
        ];

        deployment = {
          targetUser = user;
          allowLocalDeployment = true;
        };
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      colmena = {
        meta = {
          description = "All my NixoS machines";
          specialArgs = {
            flake = self;
          };
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ ];
          };
        };

        bengal = mkHost { hostname = "bengal"; };

        maine-coon = mkHost { hostname = "maine-coon"; };
      };
      nixosConfigurations.test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          flake = self;
        };
        modules = [
          ./modules
          ./hosts/test-vm/configuration.nix
          (import "${home-manager}/nixos")
        ];
      };
    };
}
