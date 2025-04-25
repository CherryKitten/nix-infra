{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../users/root
    ../../users/sammy
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
        "sammy"
      ];
    };
    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };

  users.mutableUsers = true;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  time.timeZone = lib.mkDefault "Europe/Berlin";

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "de";
    useXkbConfig = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  services.openssh = {
    enable = true;
    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
    settings = {
      PermitRootLogin = lib.mkOverride 999 "no";
      PasswordAuthentication = false;
      Macs = [
        "hmac-sha2-512"
        "hmac-sha2-256"
      ];
      KexAlgorithms = [
        "sntrup761x25519-sha512@openssh.com"
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group-exchange-sha256"
      ];
      Ciphers = [
        "aes256-gcm@openssh.com"
        "aes128-gcm@openssh.com"
        "aes256-ctr"
        "aes192-ctr"
        "aes128-ctr"
      ];
    };
  };

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
      keepTerminfo = true;
    };

    acme = {
      acceptTerms = true;
      defaults.email = "admin@cherrykitten.dev";
    };
  };

  services.fail2ban = {
    enable = lib.mkDefault true;
    maxretry = 5;
  };

  services.udev.packages = with pkgs; [
    libu2f-host
    yubikey-personalization
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableExtraSocket = true;
  };

  services.pcscd.enable = true;

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192;
      cores = 6;
      graphics = true;
    };
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
    users.users.sammy.hashedPassword = "";
  };

  programs.fish.enable = true;
  # Packages used on all systems
  environment.systemPackages = with pkgs; [
    bind.dnsutils
    comma
    fd
    file
    git
    gnupg
    htop
    jq
    mtr
    nmap
    openssl
    pinentry-curses
    rsync
    tcpdump
    tmux
    wget
    whois
    wireguard-tools
  ];
}
