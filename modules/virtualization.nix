{ config, pkgs, lib, ... }:
{
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192;
      cores = 6;
      graphics = true;
    };
    users.users.sammy.password = "test";
  };
}
