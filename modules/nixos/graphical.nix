{ config, lib, ... }:
let
  cfg = config.cherrykitten.graphical;
in
{
  options.cherrykitten.graphical = lib.mkEnableOption (lib.mdDoc "graphical stuffs");


  config = lib.mkIf cfg {
    services.xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      desktopManager.plasma5.bigscreen.enable = true;
      libinput.enable = true;

      xkb.layout = "de";
      xkb.options = "caps:escape";
    };
  };
}
