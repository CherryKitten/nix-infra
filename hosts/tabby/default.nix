# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, lib, inputs, ... }: {
  imports = [
    ../../profiles/desktop
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
  ];

  services.hardware.bolt.enable = true;
  cherrykitten.impermanence.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.iwd.enable = true;

  fileSystems."/mnt/Media" = {
    device = "192.168.0.3:/mnt/user/Media";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "noatime" ]; # disconnects after 10 minutes (i.e. 600 seconds)
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.fwupd.enable = true;

  services.xserver.xkb.layout = lib.mkForce "us";
  home-manager.users.sammy.wayland.windowManager.sway.config.input."*".xkb_layout = lib.mkForce "us";

  users.users.sammy.packages = with pkgs; [
    picard
    discord
  ];

  programs.steam = {
    enable = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
