{ lib, config, ... }:

let cfg = config.cherrykitten.prometheus.client;

in {
  options.cherrykitten.prometheus.client = {
    enable = lib.mkEnableOption "Prometheus client";
  };

  config = lib.mkIf cfg.enable {
    services.prometheus.exporters = {
      node = {
        enable = true;
        port = 9100;
        enabledCollectors = [ "systemd" ];
        openFirewall = true;
        listenAddress = config.cherrykitten.network.internal_IPv4;
      };
    };
  };
}
