{ pkgs, flake, ... }:
{
  imports = (builtins.attrValues flake.homeManagerModules);

  programs.git = {
    userName = "CherryKitten";
    userEmail = "sammy@cherrykitten.dev";
    signing.key = "0xC01A7CBBA617BD5F";
    signing.signByDefault = true;
  };
  home.username = "sammy";
  home.homeDirectory = "/home/sammy";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
  };

  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ../../files/cherrykitten.pgp;
        trust = "ultimate";
      }

    ];
  };
}
