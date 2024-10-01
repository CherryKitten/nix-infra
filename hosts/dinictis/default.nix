{ pkgs, lib, ... }: {
  imports = [
    ../../profiles/desktop
    ./hardware-configuration.nix
  ];

  services.xserver.xkb.layout = lib.mkForce "de";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.iwd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  users.users.sammy.packages = with pkgs; [
    picard
  ];

  home-manager.users.sammy.programs.ssh.includes = [
    "./famedly-config"
  ];
  home-manager.users.sammy.programs.git.includes = [
    {
      path = "~/famedly/.gitconfig";
      condition = "gitdir:~/famedly/";
    }
  ];

  fileSystems."/mnt/Media" = {
    device = "192.168.0.3:/mnt/user/Media";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "noatime" ]; # disconnects after 10 minutes (i.e. 600 seconds)
  };

  system.stateVersion = "23.11"; # Did you read the comment?

  # Famedly compliance foo - stolen from evelyn :3

  systemd.user.services.usbguard-notifier.enable = true;

  services.clamav = {
    daemon = {
      enable = true;
    };
    updater = {
      enable = true;
      frequency = 24;
      interval = "hourly";
    };
  };

  deployment.keys."osquery-secret.txt" = {
    keyCommand = [ "pass" "work/osquery-secret" ];

    destDir = "/etc/osquery/";
    uploadAt = "pre-activation";
  };

  services.osquery = {
    enable = true;
    flags = {
      tls_hostname = "fleet.famedly.de";
      host_identifier = "instance";
      enroll_secret_path = "/etc/osquery/osquery-secret.txt";
      enroll_tls_endpoint = "/api/osquery/enroll";
      config_plugin = "tls";
      config_tls_endpoint = "/api/v1/osquery/config";
      config_refresh = "10";
      disable_distributed = "false";
      distributed_plugin = "tls";
      distributed_interval = "10";
      distributed_tls_max_attempts = "3";
      distributed_tls_read_endpoint = "/api/v1/osquery/distributed/read";
      distributed_tls_write_endpoint = "/api/v1/osquery/distributed/write";
      logger_plugin = "tls";
      logger_tls_endpoint = "/api/v1/osquery/log";
      logger_tls_period = "10";
      disable_carver = "false";
      carver_start_endpoint = "/api/v1/osquery/carve/begin";
      carver_continue_endpoint = "/api/v1/osquery/carve/block";
      carver_block_size = "2000000";
      tls_server_certs = "/etc/ssl/certs/ca-certificates.crt";
    };
  };
}
