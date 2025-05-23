{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7a713df7-7027-4ae6-b1a3-839dda62dcbc";
    fsType = "btrfs";
  };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/fbd8d597-8cdb-4c6b-9fa0-b05f4cbfce86";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B4A7-702B";
    fsType = "vfat";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/8cca600e-735e-4486-92e3-01ff6c0b7599"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
