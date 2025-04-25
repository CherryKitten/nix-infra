{ lib, config, ... }:

let
  cfg = config.cherrykitten.grafana;

in
with lib;
{
  options.cherrykitten.grafana = {
    enable = mkEnableOption "Grafana";
    hostname = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    services.grafana = {
      enable = true;
      settings = {

        server = {
          domain = cfg.hostname;
          http_port = 8571;
        };
      };
    };

    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
    services.nginx.enable = true;
    services.nginx.virtualHosts.${cfg.hostname} = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8571";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
      extraConfig = ''
        access_log /var/log/nginx/grafana.access.log;
      '';
    };
  };
}
