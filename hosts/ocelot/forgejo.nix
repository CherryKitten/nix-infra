{ pkgs, ... }:
let
  bind-address = "127.0.0.1";
  host = "git.cherrykitten.dev";
  port = 3000;
in
{
  services.forgejo = {
    enable = true;
    stateDir = "/mnt/forgejo";
    package = pkgs.forgejo;
    user = "git";
    settings = {
      server = {
        DOMAIN = host;
        ROOT_URL = "https://${host}";
        HTTP_ADDR = bind-address;
        HTTP_PORT = port;
      };
      DEFAULT = {
        APP_NAME = "CherryKitten";
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
      repository = {
        ENABLE_PUSH_CREATE_USER = true;
        ENABLE_PUSH_CREATE_ORG = true;
      };
    };
  };

  users.users = {
    git = {
      home = "/mnt/forgejo";
      useDefaultShell = true;
      group = "forgejo";
      isSystemUser = true;
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
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
