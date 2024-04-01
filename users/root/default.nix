{ pkgs, lib, ... }:
{
  deployment.keys."root_password_hash" = {
    destDir = "/nix/persist/keys";
    keyCommand = [ "pass" "users/root/hashedPassword" ];
  };

  users.users.root = {
    shell = pkgs.fish;
    hashedPasswordFile = lib.mkDefault "/nix/persist/keys/root_password_hash";
  };

  home-manager.users.root = import ./home.nix;
}
