{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
  };

  home.file = {
    fish_prompt = {
      source = ./fish_prompt.fish;
      target = ".config/fish/functions/fish_prompt.fish";
    };
    fish_right_prompt = {
      source = ./fish_right_prompt.fish;
      target = ".config/fish/functions/fish_right_prompt.fish";
    };
  };
}
