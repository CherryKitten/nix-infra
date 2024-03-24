{ config, lib, pkgs, ... }: {

  imports = [
    ../../modules/common
    ../../modules/graphical
  ];

  cherrykitten.graphical.enable = false;

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "admin";
    group = "admin";
  };

  users.groups.admin = { };

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192;
      cores = 6;
      graphics = true;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = lib.mkForce true;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
  environment.systemPackages = with pkgs; [
    htop
  ];

  system.stateVersion = "23.10";
}
