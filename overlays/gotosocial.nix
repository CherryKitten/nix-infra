final: prev: {
  gotosocial =
    let
      version = "0.19.0-rc1";
      web-assets = prev.fetchurl {
        url = "https://github.com/superseriousbusiness/gotosocial/releases/download/v${version}/gotosocial_${version}_web-assets.tar.gz";
        hash = "sha256-JgV55NR8xKKIxWl1mNuKIwmWnHOXD5e5WxprhcEk8GM=";
      };
    in
    prev.gotosocial.overrideAttrs {
      inherit version;
      doCheck = false;
      src = prev.fetchFromGitHub {
        owner = "superseriousbusiness";
        repo = "gotosocial";
        rev = "refs/tags/v${ version }";
        hash = "sha256-pncGwZJY1R5rbxUhRim79lXLqqb/lbAwAchLifKj2/A=";
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
