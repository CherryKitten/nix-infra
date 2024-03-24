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

  home-manager.useUserPackages = true;
  home-manager.users = {
    sammy.imports = [./sammy.nix];
  };
}
