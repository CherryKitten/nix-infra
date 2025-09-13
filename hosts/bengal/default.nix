{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  
  cherrykitten.profile = "desktop";
  boot.loader.systemd-boot.enable = true;

  networking.networkmanager.enable = true;

  services.printing.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
