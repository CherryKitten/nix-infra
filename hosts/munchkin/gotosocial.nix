{ ... }:
let
  bind-address = "127.0.0.1";
  host = "thebleakest.link";
  port = 8553;
in
{
  services.gotosocial = {
    enable = true;
    settings = {
      inherit bind-address host port;
      application-name = "The Bleakest Link - GoToSocial";
      landing-page-user = "roughling";

      instance-expose-suspended = true;
      instance-expose-suspended-web = true;
      accounts-registration-open = false;
      accounts-allow-custom-css = true;

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

      db-type = "sqlite";
      db-address = "/var/lib/gotosocial/database.sqlite";
      storage-backend = "local";
      storage-local-base-path = "/var/lib/gotosocial/storage";

    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  services.nginx = {
    enable = true;
    clientMaxBodySize = "80M";
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
