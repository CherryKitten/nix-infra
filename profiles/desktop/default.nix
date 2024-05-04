{ pkgs, ... }: {

  imports = [
    ./sway.nix
    ./mako.nix
    ./wofi.nix
    ./waybar.nix
    ./foot.nix
    ./firefox.nix
  ];

  users.users.sammy.packages = with pkgs; [
    telegram-desktop
  ];

  services.logind.lidSwitch = "suspend-then-hibernate";
  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "poweroff";

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    libinput.enable = true;

    xkb.layout = "de";
    xkb.options = "caps:escape";
  };

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
      monospace = [ "JetBrains Mono" ];
      emoji = [ "noto-fonts-emoji" "font-awesome" ];
    };
  };
}
