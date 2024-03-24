{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [../nvim];
  home.username = "sammy";
  home.homeDirectory = "/home/sammy";
  home.stateVersion = "23.11"; # Please read the comment before changing.
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
      userName = "CherryKitten";
      userEmail = "git@cherrykitten.dev";
      signing.key = "0xC01A7CBBA617BD5F";
      signing.signByDefault = true;
      extraConfig = {
        init = {defaultBranch = "main";};
        core = {editor = "nvim";};
        pull.rebase = true;
      };
    };

    fish = {
      enable = true;
      functions = {};
    };
  };

  home.file = {
    fish_prompt = {
      source = ../fish/fish_prompt.fish;
      target = ".config/fish/functions/fish_prompt.fish";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
