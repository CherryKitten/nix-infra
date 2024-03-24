{ lib, config, pkgs, ... }: {


  home-manager.useGlobalPkgs = true;
  home-manager.users.sammy = {
    imports = [ ./neovim.nix ];
    home.username = "sammy";
    home.homeDirectory = "/home/sammy";
    home.stateVersion = "23.11"; # Please read the comment before changing.
    home.packages = with pkgs; [
      bat
      lsd
      gnupg
      kitty
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
          init = { defaultBranch = "main"; };
          core = { editor = "nvim"; };
          pull.rebase = true;
        };

      };

      nushell = {
        enable = true;
      };
    };

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. If you don't want to manage your shell through Home
    # Manager then you have to manually source 'hm-session-vars.sh' located at
    # either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/sammy/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    # Let Home Manager install and manage itself.
  };
}
