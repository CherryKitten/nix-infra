{ pkgs, ... }: {
  users.users.sammy.packages = with pkgs; [ mako ];
  home-manager.users.sammy = {
    services.mako = {
      enable = true;
      defaultTimeout = 10000;
      borderColor = "#ffffff";
      backgroundColor = "#00000070";
      textColor = "#ffffff";
    };
    wayland.windowManager.sway.config.startup = [{
      command = "${pkgs.mako}/bin/mako";
      always = false;
    }];
  };
}
