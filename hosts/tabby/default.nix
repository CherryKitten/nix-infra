# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [
    ../../profiles/desktop
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
  ];
  cherrykitten.impermanence.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/mnt/Media" = {
    device = "192.168.0.3:/mnt/user/Media";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "noatime"
    ]; # disconnects after 10 minutes (i.e. 600 seconds)
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.fwupd.enable = true;

  services.xserver.xkb.layout = lib.mkForce "us";

  users.users.sammy.packages = with pkgs; [
    picard
    discord
    inkscape
    pkgs-unstable.osu-lazer-bin
    plexamp
    plex
    godot_4
    aseprite
    blender-hip
    distrobox
    noto-fonts
    krita
  ];

  programs.steam = {
    enable = true;
  };

  hardware.steam-hardware.enable = true;
  services.usbmuxd.enable = true;

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse # optional, to mount using 'ifuse'
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}


