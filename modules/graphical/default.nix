{ pkgs, config, lib, ... }: {
  home-manager.users.sammy = {
    programs = {

      librewolf.enable = true;

      kitty = {
        enable = true;
        theme = "Catppuccin-Mocha";
      };
    };
  };
}
