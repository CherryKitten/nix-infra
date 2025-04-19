final: prev: {
  gotosocial =
    let
      version = "0.19.0-rc2";
      web-assets = prev.fetchurl {
        url = "https://github.com/superseriousbusiness/gotosocial/releases/download/v${version}/gotosocial_${version}_web-assets.tar.gz";
        hash = "sha256-Ixg8qmg0eeY/lD5Rye3xazc98GICUrzvZ7i/o7EdM+8=";
      };
    in
    prev.gotosocial.overrideAttrs {
      inherit version;
      doCheck = false;
      src = prev.fetchFromGitHub {
        owner = "superseriousbusiness";
        repo = "gotosocial";
        rev = "refs/tags/v${ version }";
        hash = "sha256-F/Js5rdrGOrwvLNv98RNYbTe3eweRj2hAXoxEox7AsI=";
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
