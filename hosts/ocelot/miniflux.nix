{ config, ... }:
let
  bind-address = "127.0.0.1";
  host = "rss.cherrykitten.dev";
  port = 4269;
in
{
  deployment.keys."miniflux_admin" = {
    destDir = "/nix/keys/";
    keyCommand = [ "pass" "services/miniflux/admin" ];
  };

  services.miniflux = {
    enable = true;
    config = {
      LISTEN_ADDR = "${bind-address}:${builtins.toString port}";
      BASE_URL = "https://${host}";
    };
    adminCredentialsFile = config.deployment.keys."miniflux_admin".path;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.nginx = {
    enable = true;
    virtualHosts = {
      "${host}" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            recommendedProxySettings = true;
            proxyWebsockets = true;
            proxyPass = "http://${bind-address}:${toString port}";
          };
        };
      };
    };
  };
}
