{
  pkgs,
  pkgs-unstable,
  flake,
  ...
}:
{

  imports = [
    ./foot.nix
    ./firefox.nix
  ];

  users.users.sammy.packages = with pkgs; [
    telegram-desktop
    mpv
    thunderbird
    obsidian
    bluez-tools
    blueman
    pavucontrol
    pinentry-all
  ];

  home-manager.users.sammy.services.nextcloud-client.enable = true;
  home-manager.users.sammy.cherrykitten.nvim.minimal = false;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver = {
    enable = true;

    libinput.enable = true;

    xkb.layout = "us";
    xkb.options = "caps:escape";
  };

  services.rpcbind.enable = true; # needed for NFS

  # Enable sound.
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  services.pipewire.enable = false;

  hardware.bluetooth.enable = true;
  services.logind.lidSwitch = "suspend-then-hibernate";
  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "poweroff";

  services.hardware.bolt.enable = true;

  networking.networkmanager.enable = true;

  powerManagement.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Source Han Serif"
      ];
      sansSerif = [
        "Noto Sans"
        "Source Han Sans"
      ];
      monospace = [ "JetBrains Mono" ];
      emoji = [
        "noto-fonts-emoji"
        "font-awesome"
      ];
    };
  };

  home-manager.sharedModules = [ flake.inputs.plasma-manager.homeManagerModules.plasma-manager ];
  home-manager.users.sammy.programs.plasma = import ./plasma-home.nix;
}
