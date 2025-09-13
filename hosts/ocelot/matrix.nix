{ ... }:
{
  services.matrix-synapse = {
    enable = true;
    dataDir = "/mnt/matrix/synapse/";
    settings = {
      server_name = "cherrykitten.gay";
      max_upload_size = "200M";
      media_store_path = "/mnt/matrix/synapse/media";
      enable_registration = false;
      listeners = [
        {
          bind_addresses = [
            "127.0.0.1"
          ];
          port = 8008;
          resources = [
            {
              compress = true;
              names = [
                "client"
              ];
            }
            {
              compress = false;
              names = [
                "federation"
              ];
            }
          ];
          tls = false;
          type = "http";
          x_forwarded = true;
        }
      ];
    };
  };

  services.nginx = {
    enable = true;
    clientMaxBodySize = "80M";
    virtualHosts = {
      "matrix.cherrykitten.gay" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            recommendedProxySettings = true;
            proxyWebsockets = true;
            proxyPass = "http://127.0.0.1:8008";
          };
        };
      };
      "cherrykitten.gay" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          ".well-known/matrix/server" = {
            return = "200 {\"m.server\": \"chat.cherrykitten.dev:443\"}";
          };
          ".well-known/matrix/client" = {
            return = "200 {\"m.homeserver\": {\"base_url\": \"https://chat.cherrykitten.gay:443\"}}";
          };
        };
      };
    };
  };
}
