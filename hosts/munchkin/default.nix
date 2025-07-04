{ lib, config, ... }:
{
  imports = [
    ../../profiles/hcloud
    ./gotosocial.nix
  ];

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  networking = {
    nameservers = [
      "2a01:4ff:ff00::add:1"
      "2a01:4ff:ff00::add:2"
      "185.12.64.1"
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
          {
            address = "5.75.143.135";
            prefixLength = 32;
          }
        ];
        ipv6.addresses = [
          {
            address = "2a01:4f8:1c1b:4c9f::1";
            prefixLength = 64;
          }
          {
            address = "fe80::9400:4ff:fe5d:e075";
            prefixLength = 64;
          }
        ];
        ipv4.routes = [
          {
            address = "172.31.1.1";
            prefixLength = 32;
          }
        ];
        ipv6.routes = [
          {
            address = "fe80::1";
            prefixLength = 128;
          }
        ];
      };
      enp7s0 = {
        ipv4.addresses = [
          {
            address = "10.69.0.3";
            prefixLength = 32;
          }
        ];
        ipv6.addresses = [
          {
            address = "fe80::8400:ff:feba:7ef7";
            prefixLength = 64;
          }
        ];
      };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="96:00:04:5d:e0:75", NAME="eth0"
    ATTR{address}=="86:00:00:ba:7e:f7", NAME="enp7s0"
  '';

  system.stateVersion = "24.05";

}
