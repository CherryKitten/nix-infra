{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, colmena, ... }:
    let
      inherit (self) outputs;
      systems = [ "aarch64-linux" "i686-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forEachSystem = f: lib.genAttrs systems (system: f);
      forAllSystems = lib.genAttrs systems;
      lib = nixpkgs.lib // home-manager.lib;
      mkHost = { hostname, user ? "sammy", }: {
        imports = [ ./hosts/${hostname}/configuration.nix ./modules/nixos/common.nix (import "${home-manager}/nixos") ];

        deployment = {
          targetUser = user;
          allowLocalDeployment = true;
        };
      };
    in
    rec {
      inherit lib;
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { system = system; }; in
        {
          default = pkgs.mkShell { nativeBuildInputs = [ pkgs.nix pkgs.colmena pkgs.git pkgs.home-manager ]; };
        });

      colmenaHive = colmena.lib.makeHive {
        meta = {
          description = "All my NixoS machines";
          specialArgs = { inherit inputs outputs; };
          nixpkgs = import nixpkgs { system = "x86_64-linux"; };
        };

        bengal = mkHost { hostname = "bengal"; };
        maine-coon = mkHost { hostname = "maine-coon"; };
      };

      nixosConfigurations = {
        test = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./modules/nixos/common.nix ./hosts/test-vm/configuration.nix (import "${home-manager}/nixos") ];
        };
      } // colmenaHive.nodes;
      homeConfigurations.sammy =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in
        lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./modules/users/sammy.nix ];
        };
    };
}
