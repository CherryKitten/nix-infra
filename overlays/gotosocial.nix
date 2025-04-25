final: prev: {
  gotosocial =
    let
      version = "0.19.0";
      web-assets = prev.fetchurl {
        url = "https://github.com/superseriousbusiness/gotosocial/releases/download/v${version}/gotosocial_${version}_web-assets.tar.gz";
        hash = "sha256-Ba497VKK30MWcLlR4CDDUrFZKWf/UXiSgeDr/f7fFkc=";
      };
    in
    prev.gotosocial.overrideAttrs {
      inherit version;
      doCheck = false;
      src = prev.fetchFromGitHub {
        owner = "superseriousbusiness";
        repo = "gotosocial";
        rev = "refs/tags/v${ version }";
        hash = "sha256-ioIsa2L1w4z1b7tWFhHScmPwRRq0WLngIdm4r2eCveM=";
      };
      postInstall = ''
        tar xf ${web-assets}
        mkdir -p $out/share/gotosocial
        mv web $out/share/gotosocial/
      '';
      ldflags = [
        "-s"
        "-w"
        "-X main.Version=${version}"
      ];

    };
}
