{ inputs, self, lib, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
  inherit (self) outputs;
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; };
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

        defaults = { lib, config, name, nodes, ... }: {
          imports = [
            ./hosts/${name}
            ./profiles/base
            (import ./overlays)
            inputs.home-manager.nixosModules.home-manager
          ] ++ builtins.attrValues self.nixosModules;

          options.cherrykitten = {
            primaryIPv4 = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default =
                if (config.networking.interfaces ? eth0) then
                  (builtins.elemAt config.networking.interfaces.eth0.ipv4.addresses 0).address
                else null;
            };
            primaryIPv6 = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default =
                if (config.networking.interfaces ? eth0) then
                  (builtins.elemAt config.networking.interfaces.eth0.ipv6.addresses 0).address
                else null;
            };
          };

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
      } // hosts;

    colmenaHive = inputs.colmena.lib.makeHive colmena;

    nixosConfigurations = {
      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ inputs.home-manager.nixosModules.home-manager ./profiles/iso ];
      };
    } // colmenaHive.nodes;
  };
}
