{ lib, config, ... }: {
  imports = [ ../../profiles/hcloud ];

  fileSystems."/" = { device = "/dev/sda1"; fsType = "ext4"; };
  cherrykitten.backups.enable = true;
  cherrykitten.prometheus = {
    server.enable = true;
    client.enable = true;
  };
  cherrykitten.grafana = {
    enable = true;
    hostname = "graph.cherrykitten.dev";
  };
  cherrykitten.network = {
    public_IPv4 = "116.203.116.228";
    public_IPv6 = "2a01:4f8:1c1b:5db9::1";
    internal_IPv4 = "10.69.0.2";
    internal_IPv6 = "fe80::8400:ff:fe8e:e0a0";
  };

  networking = {
    nameservers = [
      "2a01:4ff:ff00::add:2"
      "2a01:4ff:ff00::add:1"
      "185.12.64.2"
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
      ens10 = {
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
    ATTR{address}=="96:00:03:60:ec:55", NAME="eth0"
    ATTR{address}=="86:00:00:8e:e0:a0", NAME="ens10"
  '';

  system.stateVersion = "23.11";
}
