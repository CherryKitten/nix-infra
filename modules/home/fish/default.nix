{ lib, ... }:
{
  options.cherrykitten.fish = {
    enable = lib.mkEnableOption "Fish Shell";
  } // { default = true; };
  config = {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set -g fish_greeting
        set -g fish_key_bindings fish_vi_key_bindings

        set -x GPG_TTY (tty)
        gpgconf --launch gpg-agent
        gpg-connect-agent updatestartuptty /bye > /dev/null
      '';

      shellAliases = {
        g = "git";
      };
    };
  };
}
