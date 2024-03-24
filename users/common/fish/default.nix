{ ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting
      set -g fish_key_bindings fish_vi_key_bindings

      set -e SSH_AUTH_SOCK
      set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
      set -x GPG_TTY (tty)
      gpgconf --launch gpg-agent

    '';

    shellAliases = {
      g = "git";
    };

  };
}
