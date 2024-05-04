{ pkgs, ... }: {
  users.users.sammy.packages = with pkgs; [ waybar ];
  home-manager.users.sammy = {
    xdg.configFile."waybar/config".source = ./waybar-config.json;
    xdg.configFile."waybar/style.css".source = ./waybar-style.css;
    wayland.windowManager.sway.config.startup = [{
      command = "${pkgs.waybar}/bin/waybar";
      always = true;
    }];
  };
}

