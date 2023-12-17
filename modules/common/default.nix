{ lib, config, pkgs, ... }: {
  imports = [
    ../../users
    ./home.nix
    ./yubikey.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Berlin";

  # Packages used on all systems
  environment.systemPackages = with pkgs; [
    git
    openssl
    rsync
    pinentry
    wget
  ];

}


