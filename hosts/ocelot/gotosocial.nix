{ pkgs-unstable, ... }:
let
  bind-address = "127.0.0.1";
  host = "gts-test.cherrykitten.xyz";
  port = 8553;
in
{
  services.gotosocial = {
    enable = true;
    setupPostgresqlDB = true;
    package = pkgs-unstable.gotosocial;
    settings = {
      inherit bind-address host port;
      application-name = "CherryKitten";
      setupPostgresqlDB = true;
      landing-page-user = "sammy";

      instance-expose-suspended = true;
      instance-expose-suspended-web = true;
      accounts-registration-open = false;

      media-image-max-size = 41943040;
      media-video-max-size = 83886080;
      media-description-max-chars = 3000;
      media-remote-cache-days = 14;
      media-emoji-local-max-size = 204800;
      media-emoji-remote-max-size = 204800;

      statuses-max-chars = 69420;
      statuses-cw-max-chars = 200;
      statuses-poll-max-options = 10;
      statuses-poll-option-max-chars = 150;
      statuses-media-max-files = 16;
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.nginx = {
    enable = true;
    clientMaxBodySize = "40M";
    virtualHosts = {
      "${host}" = {
        forceSSL = false;
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

