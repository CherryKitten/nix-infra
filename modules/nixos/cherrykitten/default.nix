{
  config,
  lib,
  nodes,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./profiles/base
    ./profiles/desktop
    ./profiles/hcloud
  ];

  options.cherrykitten = {
    profile = mkOption {
      type = types.enum [
        "minimal"
        "hcloud"
        "desktop"
      ];
    };
    network = {
      public_IPv4 = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      public_IPv6 = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      internal_IPv4 = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      internal_IPv6 = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };

  config = {
    networking.hosts = {
      "${nodes.ocelot.config.cherrykitten.network.internal_IPv4}" = [ "ocelot" ];
      "${nodes.serval.config.cherrykitten.network.internal_IPv4}" = [ "serval" ];
      "${nodes.munchkin.config.cherrykitten.network.internal_IPv4}" = [ "munchkin" ];
    };
  };
}
