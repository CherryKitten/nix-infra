{ lib
, pkgs
, config
, ...
}:
let
  cfg = config.cherrykitten;
in
{

  options.cherrykitten.users = { };

  config = {
    users.users = {
      sammy = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        shell = pkgs.fish;
        ignoreShellProgramCheck = true;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZyQSZw+pExsx2RXB+yxbaJGB9mtvudbQ/BP7E1yKvr openpgp:0x6068FEBB" ];
      };
    };

    home-manager.users.sammy = {
      imports = [ ../nvim ];
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
            init = { defaultBranch = "main"; };
            core = { editor = "nvim"; };
            pull.rebase = true;
          };
        };

        fish = {
          enable = true;
          functions = { };
        };
      };

      home.file = {
        fish_prompt = {
          source = ../../files/config/fish/functions/fish_prompt.fish;
          target = ".config/fish/functions/fish_prompt.fish";
        };
        fish_right_prompt = {
          source = ../../files/config/fish/functions/fish_right_prompt.fish;
          target = ".config/fish/functions/fish_right_prompt.fish";
        };
      };

      home.sessionVariables = {
        EDITOR = "nvim";
      };
    };
  };
}
