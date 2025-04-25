{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop
  ];

  boot.loader.systemd-boot.enable = true;

  networking.networkmanager.enable = true;

  services.printing.enable = true;

  hardware.pulseaudio.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
