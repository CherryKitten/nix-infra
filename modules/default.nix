{ pkgs, config, lib, ... }:
let
  cfg = config.cherrykitten;
in
with lib;
{
  imports = [
  ./common.nix
  ./graphical.nix
  ./security.nix
  ./users.nix
  ./yubikey.nix
  ./nvim
  ./shell/fish.nix

  ];
  options.cherrykitten = { };

  config = {

    cherrykitten.fish.enable = mkDefault true;
    cherrykitten.graphical.enable = mkDefault false;
    };
}
