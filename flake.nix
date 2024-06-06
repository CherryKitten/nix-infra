{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    cherrykitten-website = {
      url = "git+https://git.cherrykitten.dev/sammy/cherrykitten.dev?ref=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ { self, flake-parts, nixpkgs, nixpkgs-unstable, home-manager, colmena, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./hive.nix
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem = { config, pkgs, ... }: {

        formatter = pkgs.nixpkgs-fmt;
        devShells =
          let
            packages = [ pkgs.nix pkgs.colmena pkgs.just pkgs.git pkgs.home-manager pkgs.pass pkgs.nixos-rebuild ];
          in
          {
            default = pkgs.mkShell {
              nativeBuildInputs = packages;
              shellHook = "exec $SHELL";
            };
            hcloud = pkgs.mkShell {
              nativeBuildInputs = packages ++ [ pkgs.hcloud ];
              shellHook = ''
                export HCLOUD_TOKEN=$(pass services/hcloud/api_token)
                exec $SHELL
              '';
            };
          };
      };

      flake =
        {

          nixosModules = builtins.listToAttrs (
            map
              (x: {
                name = x;
                value = import (./modules/nixos + "/${x}");
              })
              (builtins.attrNames (builtins.readDir ./modules/nixos))
          );

          homeManagerModules = builtins.listToAttrs (
            map
              (name: {
                inherit name;
                value = import (./modules/home + "/${name}");
              })
              (builtins.attrNames (builtins.readDir ./modules/home))
          );

          packages.x86_64-linux.iso = self.nixosConfigurations.iso.config.system.build.isoImage;
        };
    };
}
