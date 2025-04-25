{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cherrykitten-website = {
      url = "git+https://git.cherrykitten.dev/sammy/cherrykitten.dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      colmena,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./hive.nix
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem =
        {
          lib,
          config,
          pkgs,
          system,
          ...
        }:
        {

          formatter = pkgs.nixfmt-rfc-style;

          packages = {
            ansible-inventory =
              let
                hostInfo = {
                  networking = {
                    hostName = null;
                    domain = null;
                  };
                };
                hosts = lib.genAttrs (lib.mapAttrsToList (name: _: name) self.nixosConfigurations) (
                  name:
                  lib.mapAttrsRecursive (
                    path: _: lib.getAttrFromPath path self.nixosConfigurations.${name}.config
                  ) hostInfo
                );
              in
              pkgs.writeText "ansible-inventory.json" ''
                {
                  "all": {
                    "hosts": ${builtins.toJSON hosts},
                  }
                }
              '';
          };

          devShells =
            let
              packages = [
                pkgs.nix
                colmena.outputs.packages.${system}.colmena
                pkgs.just
                pkgs.git
                pkgs.home-manager
                pkgs.pass
                pkgs.nixos-rebuild
                pkgs.ansible
              ];
            in
            {
              default = pkgs.mkShell {
                nativeBuildInputs = packages;
                shellHook = ''
                  export PASSWORD_STORE_DIR=./secrets
                  export ANSIBLE_INVENTORY=${self.packages.${system}.ansible-inventory}
                '';
              };
              hcloud = pkgs.mkShell {
                nativeBuildInputs = packages ++ [ pkgs.hcloud ];
                shellHook = ''
                  export PASSWORD_STORE_DIR=./secrets
                  export HCLOUD_TOKEN=$(pass services/hcloud/api_token)
                '';
              };
            };
        };

      flake = {

        nixosModules = builtins.listToAttrs (
          map (x: {
            name = x;
            value = import (./modules/nixos + "/${x}");
          }) (builtins.attrNames (builtins.readDir ./modules/nixos))
        );

        homeManagerModules = builtins.listToAttrs (
          map (name: {
            inherit name;
            value = import (./modules/home + "/${name}");
          }) (builtins.attrNames (builtins.readDir ./modules/home))
        );

        packages.x86_64-linux.iso = self.nixosConfigurations.iso.config.system.build.isoImage;
      };
    };
}
