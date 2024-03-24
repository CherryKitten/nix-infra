{ pkgs, config, lib, ... }:
let
  cfg = config.cherrykitten.users;
in
{
  options.cherrykitten.users = {
    sammy.enable = lib.mkEnableOption "sammy" // { default = true; };
  };

  config = {
    users.users.sammy = lib.mkIf cfg.sammy.enable {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.fish;
      ignoreShellProgramCheck = true;
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZyQSZw+pExsx2RXB+yxbaJGB9mtvudbQ/BP7E1yKvr openpgp:0x6068FEBB" ];
    };

    home-manager.users.sammy = lib.mkIf cfg.sammy.enable (import ../home/users/sammy.nix);
  };
}
