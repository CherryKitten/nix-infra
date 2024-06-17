final: prev: {
  gotosocial =
    let
      version = "0.16.0-rc3";
      web-assets = prev.fetchurl {
        url = "https://github.com/superseriousbusiness/gotosocial/releases/download/v${version}/gotosocial_${version}_web-assets.tar.gz";
        hash = "sha256-HlpctwO58owAbPc3BJpid1LP8B956L7HqWI10iy3jOU=";
      };
    in
    prev.gotosocial.overrideAttrs {
      inherit version;
      doCheck = false;
      src = prev.fetchFromGitHub {
        owner = "superseriousbusiness";
        repo = "gotosocial";
        rev = "refs/tags/v${ version }";
        hash = "sha256-jmVOMuBaojoCVCXsvcfDSsj+Oy0gosk2QQr2Paa5qL0=";
      };
      postInstall = ''
        tar xf ${web-assets}
        mkdir -p $out/share/gotosocial
        mv web $out/share/gotosocial/
      '';
    };
}
