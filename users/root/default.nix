{ pkgs, lib, ... }:
{
  deployment.keys."root_password_hash" = {
    keyCommand = [ "pass" "users/root/hashedPassword" ];
  };

  users.users.root = {
    shell = pkgs.fish;
    hashedPasswordFile = lib.mkDefault "/run/keys/root_password_hash";
  };

  home-manager.users.root = import ./home.nix;
}
