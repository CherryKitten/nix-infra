{ ... }: {
  networking.firewall.allowedTCPPorts = [ 22 ];

  services.openssh = {
    enable = true;
    extraConfig = ''
      StreamLocalBindUnlink yes
    '';
    settings = {
      PermitRootLogin = "no";
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
    enable = true;
    maxretry = 5;
  };
}