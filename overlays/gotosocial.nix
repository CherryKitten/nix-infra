final: prev: {
  gotosocial =
    let
      version = "0.18.1";
      web-assets = prev.fetchurl {
        url = "https://github.com/superseriousbusiness/gotosocial/releases/download/v${version}/gotosocial_${version}_web-assets.tar.gz";
        hash = "sha256-5MSABLPyTbFMTno9vUDvLT9h7oQM6eNUuwD+dsHiCLo=";
      };
    in
    prev.gotosocial.overrideAttrs {
      inherit version;
      doCheck = false;
      src = prev.fetchFromGitHub {
        owner = "superseriousbusiness";
        repo = "gotosocial";
        rev = "refs/tags/v${ version }";
        hash = "sha256-4jV1G1HwpIST2Y27RAhJB3CoJevwuhxdzi615hj0Qv0=";
      };
      postInstall = ''
        tar xf ${web-assets}
        mkdir -p $out/share/gotosocial
        mv web $out/share/gotosocial/
      '';
    };
}
