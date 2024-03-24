{ lib, pkgs, ... }: {
  options.cherrykitten = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "the hostname, this is already set for every host by the flake config";
    };
    test = lib.mkOption {
      type = lib.types.str;
      default = "nya";
      example = "nyanya";
    };
  };
  imports = [
    ./graphical.nix
    ./security.nix
    ./users.nix
    ./yubikey.nix
    ./virtualization.nix
  ];

  config = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    time.timeZone = "Europe/Berlin";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = lib.mkForce "de";
      useXkbConfig = true; # use xkb.options in tty.
    };

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        monaspace
        nerdfonts
      ];
      fontconfig = {
        defaultFonts.emoji = [ "Noto Emoji" ];
        defaultFonts.serif = [ "Monaspace Xenon" "FiraCode Nerd Font" "Hack Nerd Font" "NotoSans Nerd Font" ];
        defaultFonts.sansSerif = [ "Monaspace Xenon" "FiraCode Nerd Font" "Hack Nerd Font" "NotoSerif Nerd Font" ];
        defaultFonts.monospace = [ "Monaspace Xenon" "FiraCode Nerd Font" "Hack Nerd Font" ];
      };
    };

    # Packages used on all systems
    environment.systemPackages = with pkgs; [
      git
      openssl
      rsync
      pinentry
      wget
    ];
  };
}
