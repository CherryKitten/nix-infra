{ inputs, ... }: {
  services.nginx = {
    enable = true;
    virtualHosts = {
      "cherrykitten.dev" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/" = {
            root = "${inputs.cherrykitten-website.packages.x86_64-linux.website}/var/www/cherrykitten.dev";
          };
        };
      };
    };
  };
}
