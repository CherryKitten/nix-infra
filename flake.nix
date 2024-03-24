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

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, colmena, ... }:
    let
      inherit (self) outputs;
      systems = [ "aarch64-linux" "i686-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = lib.genAttrs systems;
      lib = nixpkgs.lib // home-manager.lib;
    in
    rec {
      inherit lib;
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { system = system; }; in {
          default = pkgs.mkShell {
            nativeBuildInputs = [ pkgs.nix pkgs.colmena pkgs.git pkgs.home-manager pkgs.nixos-rebuild ];
            shellHook = "exec $SHELL";
          };
        });

      colmenaHive = colmena.lib.makeHive {
        meta = {
          description = "All my NixoS machines";
          specialArgs = {
            inherit inputs outputs;
            pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; };
          };
          nixpkgs = import nixpkgs { system = "x86_64-linux"; };
        };

        defaults = { lib, config, name, ... }: {
          imports = [ ./hosts/${name}/configuration.nix ./modules/nixos/common.nix (import "${home-manager}/nixos") ];

          deployment = {
            targetUser = "sammy";
            allowLocalDeployment = true;
          };

          home-manager.extraSpecialArgs = {
            inherit inputs outputs;
            pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; };
          };
        };

        bengal = { };
        maine-coon = { };
      };

      nixosConfigurations = {
        test = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./modules/nixos/common.nix ./hosts/test-vm/configuration.nix (import "${home-manager}/nixos") ];
        };
      } // colmenaHive.nodes;

      homeConfigurations =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          mkHome = { user ? "sammy", hostname ? null }:
            lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [ ./modules/home/users/${user}.nix ] ++ lib.optional (!isNull hostname) ./modules/home/hosts/${hostname}.nix;
              extraSpecialArgs = {
                inherit inputs outputs;
                pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; };
              };
            };
        in
        {
          sammy = mkHome { };
          "sammy@chansey" = mkHome { hostname = "chansey"; };
        };
    };
}
