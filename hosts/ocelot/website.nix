{ inputs, ... }: {
  services.nginx = {
    enable = true;
    virtualHosts = {
      "cherrykitten.dev" = {
        extraConfig = "error_page 404 /404.html;";
        addSSL = true;
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
