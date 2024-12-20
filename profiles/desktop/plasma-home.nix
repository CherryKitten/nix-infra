{
  enable = true;

  workspace = {
      wallpaper = ../../files/wallpaper.png;
    };

  shortcuts = {

    kwin = {
      "Switch One Desktop Down" = "Meta+Alt+Down";
      "Switch One Desktop Up" = "Meta+Alt+Up";
      "Switch One Desktop to the Left" = "Meta+Alt+Left";
      "Switch One Desktop to the Right" = "Meta+Alt+Right";

      "Switch Window Down" = "Meta+Down";
      "Switch Window Left" = "Meta+Left";
      "Switch Window Right" = "Meta+Right";
      "Switch Window Up" = "Meta+Up";

      "Window Close" = "Meta+Q";
      "Window Maximize" = "Meta+Shift+Return";

      "Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
      "Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
      "Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
      "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";

      "Window Quick Tile Bottom" = "Meta+Shift+Down";
      "Window Quick Tile Left" = "Meta+Shift+Left";
      "Window Quick Tile Right" = "Meta+Shift+Right";
      "Window Quick Tile Top" = "Meta+Shift+Up";

      "Window to Desktop 1" = "Meta+Shift+1";
      "Window to Desktop 2" = "Meta+Shift+2";
      "Window to Desktop 3" = "Meta+Shift+3";
      "Window to Desktop 4" = "Meta+Shift+4";
      "Window to Desktop 5" = "Meta+Shift+5";
      "Window to Desktop 6" = "Meta+Shift+6";
      "Window to Desktop 7" = "Meta+Shift+7";
      "Window to Desktop 8" = "Meta+Shift+8";

      "Window to Next Desktop" = "Meta+Shift+N";
      "Window to Previous Desktop" = "Meta+Shift+P";

    };
  };

  panels = [
    {
      location = "bottom";
      floating = true;
      screen = "all";
      widgets = [
        {
          kickoff = {
            sortAlphabetically = true;
          };
        }
        "org.kde.plasma.pager"
        {
          iconTasks = {
            launchers = [
              "applications:org.kde.dolphin.desktop"
              "applications:firefox.desktop"
            ];
          };
        }
        "org.kde.plasma.marginsseparator"
        {
          digitalClock = {
            calendar.firstDayOfWeek = "monday";
            time.format = "24h";
            date.format = "isoDate";
          };
        }
        {
          systemTray.items = {
            shown = [
              "org.kde.plasma.battery"
              "org.kde.plasma.bluetooth"
              "org.kde.plasma.volume"
              "org.kde.plasma.networkmanagement"
            ];
            hidden = [];
          };
        }
      ];
    }
  ];

  input = {
    keyboard = {
      numlockOnStartup = "on";
      options = [
        "caps:escape"
      ];
    };
  };

  kwin = {
    virtualDesktops = {
      number = 8;
      rows = 2;
    };
  };
}
