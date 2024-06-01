{ config, lib, ... }:
let
  cfg = config.cherrykitten;
in
{
  options.cherrykitten = {
    network = {
      public_IPv4 = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      public_IPv6 = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      internal_IPv4 = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      internal_IPv6 = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
}
