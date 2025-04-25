{
  inputs,
  self,
  lib,
  ...
}:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
  inherit (self) outputs;
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  pkgs-unstable = import nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  flake = rec {
    colmena =
      let
        hosts = lib.genAttrs (builtins.attrNames (builtins.readDir ./hosts)) (name: { });
      in
      {
        meta = {
          description = "All my NixoS machines";
          specialArgs = {
            inherit inputs outputs pkgs-unstable;
            flake = self;
            nodes = colmenaHive.nodes;
          };
          nixpkgs = pkgs;
        };

        defaults =
          {
            lib,
            config,
            name,
            nodes,
            ...
          }:
          {
            imports = [
              ./hosts/${name}
              ./profiles/base
              (import ./overlays)
              inputs.home-manager.nixosModules.home-manager
              inputs.impermanence.nixosModules.impermanence
            ] ++ builtins.attrValues self.nixosModules;

            config = {
              networking.hostName = name;
              networking.domain = "cherrykitten.xyz";

              deployment = {
                allowLocalDeployment = true;
                targetUser = lib.mkDefault "sammy";
                tags = [ pkgs.stdenv.hostPlatform.system ];
              };
              home-manager.extraSpecialArgs = {
                inherit inputs outputs pkgs-unstable;
                flake = self;
              };
            };
          };
      }
      // hosts;

    colmenaHive = inputs.colmena.lib.makeHive colmena;

    nixosConfigurations = {
      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.home-manager.nixosModules.home-manager
          ./profiles/iso
        ];
      };
    } // colmenaHive.nodes;
  };
}
