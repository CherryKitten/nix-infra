{ pkgs, pkgs-unstable, ... }: {

  imports = [
    ./sway
    ./foot.nix
    ./firefox.nix
  ];

  users.users.sammy.packages = with pkgs; [
    telegram-desktop
    mpv
    thunderbird
    pkgs-unstable.obsidian
    bluez-tools
    blueman
    pavucontrol
  ];

  home-manager.users.sammy.services.nextcloud-client.enable = true;

  services.rpcbind.enable = true; # needed for NFS

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  hardware.bluetooth.enable = true;
  services.logind.lidSwitch = "suspend-then-hibernate";
  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "poweroff";

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };

    libinput.enable = true;

    xkb.layout = "de";
    xkb.options = "caps:escape";
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

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
