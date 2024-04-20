{ modulesPath, pkgs, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-plasma5.nix"
  ];

  networking.hostName = "nixos";
  # Enables copy / paste when running in a KVM with spice.
  services.spice-vdagentd.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  users.users.nixos.shell = pkgs.fish;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    mkpasswd
    nixpkgs-fmt
    neovim-unwrapped
    xclip
    bat
    bind.dnsutils
    fd
    git
    gnupg
    htop
    jq
    mtr
    nmap
    openssl
    rsync
    tcpdump
    tmux
    wget
    whois
  ];

  home-manager.users.nixos = {
    imports = [
      ../../modules/home/foot.nix
    ];
    home.stateVersion = "23.11";

  };
  # Use faster squashfs compression
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
