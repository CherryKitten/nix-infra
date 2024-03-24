{ lib
, config
, pkgs
, ...
}: {
  users.users = {
    sammy = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.fish;
      ignoreShellProgramCheck = true;
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZyQSZw+pExsx2RXB+yxbaJGB9mtvudbQ/BP7E1yKvr openpgp:0x6068FEBB" ];
    };
  };

  home-manager.useUserPackages = true;
  home-manager.users = {
    sammy.imports = [ ./sammy.nix ];
  };
}
