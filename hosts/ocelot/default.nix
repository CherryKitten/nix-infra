{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./gotosocial.nix
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "ocelot";
  networking.domain = "";
  system.stateVersion = "23.11";
}
