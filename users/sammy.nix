{ ... }: {
  imports = [ ./common ];

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

  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ../cherrykitten.pgp;
        trust = "ultimate";
      }

    ];
  };
}
