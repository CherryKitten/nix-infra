{
  nodes,
  lib,
  config,
  ...
}:

let
  cfg = config.cherrykitten.prometheus.server;

in
{
  options.cherrykitten.prometheus.server = {
    enable = lib.mkEnableOption "Prometheus server";
  };

  config = lib.mkIf cfg.enable {

    services.prometheus = {
      enable = true;
      retentionTime = "30d";

      scrapeConfigs = [
        {
          job_name = "node";
          honor_labels = true;
          relabel_configs = [
            {
              source_labels = [ "__address__" ];
              target_label = "instance";
              regex = "([^:]+)(:[0-9]+)?";
            }
          ];
          static_configs = [
            {
              targets = [
                "serval:9100"
                "ocelot:9100"
              ];
            }
          ];
        }
      ];
    };
  };
}
