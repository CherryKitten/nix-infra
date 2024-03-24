{ ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  cherrykitten.graphical.enable = true;

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "bengal";
  networking.networkmanager.enable = true;

  services.printing.enable = true;

  hardware.pulseaudio.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
