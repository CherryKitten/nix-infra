{ pkgs, lib, ... }:
{
  deployment.keys."sammy_password_hash" = {
    destDir = "/nix/persist/keys";
    keyCommand = [ "pass" "users/sammy/hashedPassword" ];
  };

  users.users.sammy = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZyQSZw+pExsx2RXB+yxbaJGB9mtvudbQ/BP7E1yKvr openpgp:0x6068FEBB" ];
    hashedPasswordFile = lib.mkDefault "/nix/persist/keys/sammy_password_hash";
  };

  home-manager.users.sammy = import ./home.nix;
}
