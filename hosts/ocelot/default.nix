{ lib, ... }: {
  imports = [
    ./gotosocial.nix
    ../../profiles/hcloud
  ];
  fileSystems."/" = { device = "/dev/sda1"; fsType = "ext4"; };

  networking = {
    nameservers = [
      "8.8.8.8"
    ];
    defaultGateway = "172.31.1.1";
    defaultGateway6 = {
      address = "fe80::1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address = "128.140.109.125"; prefixLength = 32; }
        ];
        ipv6.addresses = [
          { address = "2a01:4f8:c2c:bd32::1"; prefixLength = 64; }
          { address = "fe80::9400:3ff:fe24:677a"; prefixLength = 64; }
        ];
        ipv4.routes = [{ address = "172.31.1.1"; prefixLength = 32; }];
        ipv6.routes = [{ address = "fe80::1"; prefixLength = 128; }];
      };

    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="96:00:03:24:67:7a", NAME="eth0"
  '';

  system.stateVersion = "23.11";
}
