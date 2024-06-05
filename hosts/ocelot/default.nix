{ lib, config, ... }: {
  imports = [
    ./gotosocial.nix
    ../../profiles/hcloud
    ./website.nix
  ];
  fileSystems."/" = { device = "/dev/sda1"; fsType = "ext4"; };
  cherrykitten.backups.enable = true;
  cherrykitten.network = {
    public_IPv4 = "128.140.109.125";
    public_IPv6 = "2a01:4f8:c2c:bd32::1";
    internal_IPv4 = "10.69.0.5";
    internal_IPv6 = "fe80::8400:ff:fe8e:470d";
  };
  cherrykitten.prometheus.client.enable = true;

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
          { address = config.cherrykitten.network.public_IPv4; prefixLength = 32; }
        ];
        ipv6.addresses = [
          { address = config.cherrykitten.network.public_IPv6; prefixLength = 64; }
        ];
        ipv4.routes = [{ address = "172.31.1.1"; prefixLength = 32; }];
        ipv6.routes = [{ address = "fe80::1"; prefixLength = 128; }];
      };
      eth1 = {
        ipv4.addresses = [
          { address = config.cherrykitten.network.internal_IPv4; prefixLength = 32; }
        ];
        ipv6.addresses = [
          { address = config.cherrykitten.network.internal_IPv6; prefixLength = 64; }
        ];
        ipv4.routes = [
          { address = "10.69.0.1"; prefixLength = 32; }
          { address = "10.69.0.0"; prefixLength = 24; via = "10.69.0.1"; }
        ];
      };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="96:00:03:24:67:7a", NAME="eth0"
    ATTR{address}=="86:00:00:8e:47:0d", NAME="eth1"
  '';

  system.stateVersion = "23.11";
}
