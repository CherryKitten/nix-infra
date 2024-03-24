{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./gotosocial.nix
  ];

  networking.hostName = "maine-coon";

  boot.loader.grub.device = "/dev/nvme0n1";

  networking.useDHCP = false;
  networking.interfaces."enp0s31f6".ipv4.addresses = [
    {
      address = "159.69.71.253";
      prefixLength = 26;
    }
  ];
  networking.interfaces."enp0s31f6".ipv6.addresses = [
    {
      address = "2a01:4f8:231:16dc::1";
      prefixLength = 64;
    }
  ];
  networking.defaultGateway = "159.69.71.193";
  networking.defaultGateway6 = {
    address = "fe80::1";
    interface = "enp0s31f6";
  };
  networking.nameservers = [ "8.8.8.8" ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZyQSZw+pExsx2RXB+yxbaJGB9mtvudbQ/BP7E1yKvr openpgp:0x6068FEBB"
  ];

  services.openssh.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "24.05"; # Did you read the comment?
}
