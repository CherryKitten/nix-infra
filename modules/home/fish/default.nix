{ ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting
      set -g fish_key_bindings fish_vi_key_bindings
      export GPG_TTY="$(tty)"
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
      gpg-connect-agent updatestartuptty /bye > /dev/null
    '';

    shellAliases = {
      g = "git";
    };

  };
}
