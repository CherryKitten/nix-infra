{ lib, pkgs, ... }: {
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
