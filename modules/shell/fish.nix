{ pkgs, config, lib, flake, ... }:
let
  cfg = config.cherrykitten.fish;
in
with lib;
{

  options.cherrykitten.fish.enable = mkEnableOption "Fish-Shell";

  config = mkIf cfg.enable {
    home-manager.users.sammy = {

      programs.fish = {
        enable = true;
      };

      home.file = {
        fish_prompt = {
          source = flake + files/config/fish/functions/fish_prompt.fish;
          target = ".config/fish/functions/fish_prompt.fish";
        };
        fish_right_prompt = {
          source =  flake + files/config/fish/functions/fish_right_prompt.fish;
          target = ".config/fish/functions/fish_right_prompt.fish";
        };
      };

    };
  };
}
