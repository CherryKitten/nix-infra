{ pkgs, config, lib, ... }: {

  programs.tmux = {
    enable = true;

    clock24 = true;
    shortcut = "a";
    mouse = true;
    historyLimit = 30000;

    extraConfig = ''
      set -g status-position top
      setw -g mode-keys vi

      bind . split-window -h
      bind - split-window -v

      set -g base-index 1

      set -g status-bg black
      set -g status-fg green

      set-option -sg escape-time 10
      set-option -g focus-events on
      set-option -sa terminal-features ',kitty:RGB'
    '';

      };
  }

