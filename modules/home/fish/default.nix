{ ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      export GPG_TTY="$(tty)"
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
      gpg-connect-agent updatestartuptty /bye > /dev/null
    '';

    shellAliases = {
        g = "git";
      };
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
