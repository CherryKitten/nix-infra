{ flake, ... }:
{
  imports = (builtins.attrValues flake.homeManagerModules);

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
