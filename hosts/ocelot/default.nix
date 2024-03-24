{ ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  cherrykitten.graphical = false;

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "ocelot";
  networking.domain = "";
  system.stateVersion = "23.11";
}
