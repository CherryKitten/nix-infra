{pkgs, ...}: {
  services.udev.packages = with pkgs; [libu2f-host yubikey-personalization];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableExtraSocket = true;
  };

  services.pcscd.enable = true;
}
