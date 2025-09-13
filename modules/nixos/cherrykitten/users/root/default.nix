{
  pkgs,
  lib,
  config,
  ...
}:
{
  deployment.keys."root_password_hash" = {
    keyCommand = [
      "pass"
      "users/root/hashedPassword"
    ];
  };

  users.users.root = {
    shell = pkgs.fish;
    hashedPasswordFile = lib.mkDefault config.deployment.keys."root_password_hash".path;
  };

  home-manager.users.root = import ./home.nix;
}
