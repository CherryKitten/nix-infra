{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.cherrykitten.backups;
  hostname = config.networking.hostName;
in
{
  options.cherrykitten.backups = {
    enable = lib.mkEnableOption "Backups";
  };

  config = lib.mkIf cfg.enable {
    deployment.keys = {
      "restic_env" = {
        destDir = "/root/keys";
        keyCommand = [
          "pass"
          "hosts/${hostname}/restic/env"
        ];
      };
      "restic_repository_file" = {
        destDir = "/root/keys";
        keyCommand = [
          "pass"
          "hosts/${hostname}/restic/repository"
        ];
      };
      "restic_password_file" = {
        destDir = "/root/keys";
        keyCommand = [
          "pass"
          "hosts/${hostname}/restic/password"
        ];
      };
    };
    services.restic.backups = {
      default = {
        user = "root";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
        pruneOpts = [
          "--keep-daily 14"
          "--keep-weekly 6"
          "--keep-monthly 24"
        ];
        paths = [ ] ++ lib.optional (config.services.postgresql.enable) "/var/lib/postgresql";
        initialize = true;
        exclude = [
          "cache"
          ".cache"
          ".git"
        ];
        environmentFile = config.deployment.keys."restic_env".path;
        repositoryFile = config.deployment.keys."restic_repository_file".path;
        passwordFile = config.deployment.keys."restic_password_file".path;
      };
    };
  };
}
