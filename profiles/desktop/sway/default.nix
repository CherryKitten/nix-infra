{ config, pkgs, ... }: {

  imports = [
    ./mako.nix
    ./wofi.nix
  ];

  hardware.opengl.enable = true;

  programs.sway.enable = true;
  programs.light.enable = true;

  users.users.sammy.packages = with pkgs; [
    qt5.qtwayland
    wdisplays
    waypipe
    wl-clipboard
    xfce.thunar
  ];

  environment.variables.SDL_VIDEODRIVER = "wayland";
  environment.variables.QT_QPA_PLATFORM = "wayland";
  environment.variables.QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  environment.variables._JAVA_AWT_WM_NONREPARENTING = "1";
  environment.variables.NIXOS_OZONE_WL = "1";

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];

  security.pam.services.swaylock.rules.auth.fprintd = {
    order = config.security.pam.services.swaylock.rules.auth.unix.order + 10;
  };

  home-manager.users.sammy = {
    services.swayidle =
      let
        lockCommand = "${pkgs.writeShellScript "swaylock-command" ''
        ${pkgs.grim}/bin/grim -t png -l 1 /tmp/lock-screenshot.png
        ${pkgs.imagemagick}/bin/magick /tmp/lock-screenshot.png -blur 80x40 /tmp/lock-screenshot.png
        ${pkgs.swaylock}/bin/swaylock -i /tmp/lock-screenshot.png -efFl
      ''}";
      in
      {
        enable = true;
        events = [
          { event = "before-sleep"; command = lockCommand; }
          { event = "lock"; command = lockCommand; }
        ];
        timeouts = [
          { timeout = 900; command = lockCommand; }
          { timeout = 1800; command = "systemctl hybrid-sleep"; }
        ];
      };
    wayland.windowManager.sway =
      let
        cfg = config.home-manager.users.sammy.wayland.windowManager.sway;
      in
      {
        enable = true;
        wrapperFeatures.gtk = true;

        config = {
          fonts = {
            names = [ "JetBrains Mono" ];
            size = 9.0;
          };
          terminal = "foot";
          menu = "wofi --show drun";

          window = {
            border = 0;
            hideEdgeBorders = "both";
          };
          gaps.inner = 10;
          gaps.smartGaps = true;

          output = {
            "eDP-1" = {
              position = "0 1080";
            };
            "DP-6" = {
              position = "0 0";
            };
          };

          input = {
            "*" = {
              xkb_layout = "de";
              xkb_options = "caps:escape";
            };
            "type:touchpad" = {
              tap = "enabled";
            };
          };

          bars = [{
            mode = "dock";
            hiddenState = "hide";
            position = "bottom";
            workspaceButtons = true;
            workspaceNumbers = true;
            statusCommand = "${pkgs.i3status}/bin/i3status";
            fonts = {
              names = [ "JetBrains Mono" ];
              size = 10.0;
            };
            trayOutput = "primary";
            colors = {
              background = "#000000";
              statusline = "#ffffff";
              separator = "#666666";
              focusedWorkspace = {
                border = "#4c7899";
                background = "#285577";
                text = "#ffffff";
              };
              activeWorkspace = {
                border = "#333333";
                background = "#5f676a";
                text = "#ffffff";
              };
              inactiveWorkspace = {
                border = "#333333";
                background = "#222222";
                text = "#888888";
              };
              urgentWorkspace = {
                border = "#2f343a";
                background = "#900000";
                text = "#ffffff";
              };
              bindingMode = {
                border = "#2f343a";
                background = "#900000";
                text = "#ffffff";
              };
            };
          }];

          modifier = "Mod4";
          keybindings = {
            "${cfg.config.modifier}+Return" = "exec ${cfg.config.terminal}";
            "${cfg.config.modifier}+d" = "exec ${cfg.config.menu}";

            "${cfg.config.modifier}+l" = "exec loginctl lock-session";

            "${cfg.config.modifier}+Shift+e" =
              "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
            "${cfg.config.modifier}+Shift+q" = "kill";

            "${cfg.config.modifier}+Shift+s" = "exec ${pkgs.grim}/bin/grim -t png -l 1 -g \"$(${pkgs.slurp}/bin/slurp)\" ~/Pictures/screenshot-$(date +%Y-%m-%d_%H-%m-%s).png";

            "${cfg.config.modifier}+Left" = "focus left";
            "${cfg.config.modifier}+Down" = "focus down";
            "${cfg.config.modifier}+Up" = "focus up";
            "${cfg.config.modifier}+Right" = "focus right";

            "${cfg.config.modifier}+Shift+Left" = "move left";
            "${cfg.config.modifier}+Shift+Down" = "move down";
            "${cfg.config.modifier}+Shift+Up" = "move up";
            "${cfg.config.modifier}+Shift+Right" = "move right";

            "${cfg.config.modifier}+b" = "split h";
            "${cfg.config.modifier}+v" = "split v";

            "${cfg.config.modifier}+s" = "layout stacking";
            "${cfg.config.modifier}+w" = "layout tabbed";
            "${cfg.config.modifier}+e" = "layout toggle split";

            "${cfg.config.modifier}+Shift+space" = "floating toggle";
            "${cfg.config.modifier}+space" = "focus mode_toggle";
            "${cfg.config.modifier}+a" = "focus parent";

            "${cfg.config.modifier}+f" = "fullscreen toggle";

            "${cfg.config.modifier}+1" = "workspace 1";
            "${cfg.config.modifier}+2" = "workspace 2";
            "${cfg.config.modifier}+3" = "workspace 3";
            "${cfg.config.modifier}+4" = "workspace 4";
            "${cfg.config.modifier}+5" = "workspace 5";
            "${cfg.config.modifier}+6" = "workspace 6";
            "${cfg.config.modifier}+7" = "workspace 7";
            "${cfg.config.modifier}+8" = "workspace 8";
            "${cfg.config.modifier}+9" = "workspace 9";
            "${cfg.config.modifier}+0" = "workspace 10";

            "${cfg.config.modifier}+Alt+Right" = "workspace next";
            "${cfg.config.modifier}+Alt+Left" = "workspace prev";
            "${cfg.config.modifier}+Alt+Up" = "move workspace to output up";
            "${cfg.config.modifier}+Alt+Down" = "move workspace to output down";

            "${cfg.config.modifier}+Shift+1" = "move container to workspace 1";
            "${cfg.config.modifier}+Shift+2" = "move container to workspace 2";
            "${cfg.config.modifier}+Shift+3" = "move container to workspace 3";
            "${cfg.config.modifier}+Shift+4" = "move container to workspace 4";
            "${cfg.config.modifier}+Shift+5" = "move container to workspace 5";
            "${cfg.config.modifier}+Shift+6" = "move container to workspace 6";
            "${cfg.config.modifier}+Shift+7" = "move container to workspace 7";
            "${cfg.config.modifier}+Shift+8" = "move container to workspace 8";
            "${cfg.config.modifier}+Shift+9" = "move container to workspace 9";
            "${cfg.config.modifier}+Shift+0" = "move container to workspace 10";

            "${cfg.config.modifier}+Alt+N" = "move container to workspace next";
            "${cfg.config.modifier}+Alt+P" = "move container to workspace prev";

            "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pamixer}/bin/pamixer -i 5";
            "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pamixer}/bin/pamixer -d 5";
            "XF86AudioMute" = "exec --no-startup-id ${pkgs.pamixer}/bin/pamixer -t";
            "XF86AudioMicMute" = "exec --no-startup-id ${pkgs.pamixer}/bin/pamixer --default-source -t";
            "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 5";
            "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";

            "${cfg.config.modifier}+r" = "mode resize";
          };

          startup = [{
            command = "systemctl --user restart nextcloud-client";
            always = true;
          }];

        };

        extraConfig = ''
          client.focused #00000000 #000000cc #FFFFFF
          client.unfocused #00000000 #00000070 #FFFFFF
          client.focused_inactive #00000000 #00000090 #FFFFFF
        '';
      };
  };
}
