{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    libinput.enable = true;

    xkb.layout = "de";
    xkb.options = "caps:escape";
  };
  fonts = {
    enableDefaultPackages = true;
    packages = [ pkgs.noto-fonts-emoji ];
  };
}
