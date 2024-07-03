final: prev: {
  gotosocial =
    let
      version = "0.16.0";
      web-assets = prev.fetchurl {
        url = "https://github.com/superseriousbusiness/gotosocial/releases/download/v${version}/gotosocial_${version}_web-assets.tar.gz";
        hash = "sha256-aZQpd5KvoZvXEMVzGbWrtGsc+P1JStjZ6U5mX6q7Vb0=";
      };
    in
    prev.gotosocial.overrideAttrs {
      inherit version;
      doCheck = false;
      src = prev.fetchFromGitHub {
        owner = "superseriousbusiness";
        repo = "gotosocial";
        rev = "refs/tags/v${ version }";
        hash = "sha256-QoG09+jmq5e5vxDVtkhY35098W/9B1HsYTuUnz43LV4=";
      };
      postInstall = ''
        tar xf ${web-assets}
        mkdir -p $out/share/gotosocial
        mv web $out/share/gotosocial/
      '';
    };
}
