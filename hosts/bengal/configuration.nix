# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
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
