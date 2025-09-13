{
  pkgs,
  flake,
  config,
  lib,
  ...
}:
let
  profile = config.cherrykitten.profile;
in
{
  config = lib.mkIf (profile == "desktop") {

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
    home-manager.sharedModules = [ flake.inputs.plasma-manager.homeManagerModules.plasma-manager ];
    home-manager.users.sammy.programs.plasma = import ./plasma-home.nix;

    services.xserver = {
      enable = true;

      libinput.enable = true;

      xkb.layout = "us";
      xkb.options = "caps:escape";
    };

    services.rpcbind.enable = true; # needed for NFS

    # Enable sound.
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    hardware.bluetooth.enable = true;
    services.logind.lidSwitch = "suspend-then-hibernate";
    services.logind.powerKey = "hibernate";
    services.logind.powerKeyLongPress = "poweroff";

    services.hardware.bolt.enable = true;

    networking.networkmanager.enable = true;

    powerManagement.enable = true;

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    programs.firefox = {
      enable = true;
      policies = {
        DisableTelemetry = true;
        DefaultDownloadDirectory = "\${home}/Downloads";
        DisableFirefoxStudies = true;
        DisablePocket = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        ExtensionSettings =
          lib.mapAttrs
            (id: shortName: {
              installation_mode = "force_installed";
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${shortName}/latest.xpi";
            })
            {
              "FirefoxColor@mozilla.com" = "firefox-color";
              "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
              "uBlock0@raymondhill.net" = "ublock-origin";
            };
        NoDefaultBookmarks = true;
        PasswordManagerEnabled = false;
        UserMessaging = {
          WhatsNew = true;
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = true;
          SkipOnboarding = true;
          MoreFromMozilla = false;
          Locked = true;
        };
      };
    };

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
        nerd-fonts.hack
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

  };
}
