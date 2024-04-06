{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./gotosocial.nix
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  system.stateVersion = "23.11";
}
