{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [./fish ./nvim];
  home.packages = with pkgs; [
    bat
    lsd
    gnupg
    tmux
    colmena
  ];

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      extraConfig = {
        init = {defaultBranch = "main";};
        core = {editor = "nvim";};
        pull.rebase = true;
      };
    };
  };
}
