{
  lib,
  config,
  pkgs,
  ...
}: {
  users.users = {
    sammy = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "docker"];
      shell = pkgs.nushell;
    };
  };
}
