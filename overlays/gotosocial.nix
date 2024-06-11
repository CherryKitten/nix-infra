final: prev: {
  gotosocial =
    let
      version = "0.16.0-rc2";
      web-assets = prev.fetchurl {
        url = "https://github.com/superseriousbusiness/gotosocial/releases/download/v${version}/gotosocial_${version}_web-assets.tar.gz";
        hash = "sha256-fufQP9xaaaVBrgFSunDn9/jQd6eUMXqGL7TcoQHatnI=";
      };
    in
    prev.gotosocial.overrideAttrs {
      inherit version;
      doCheck = false;
      src = prev.fetchFromGitHub {
        owner = "superseriousbusiness";
        repo = "gotosocial";
        rev = "refs/tags/v${ version }";
        hash = "sha256-+H4rpUgjDlCc6tEIGTzkPYktwo9aCWgXr5sln8M6DNk=";
      };
      postInstall = ''
        tar xf ${web-assets}
        mkdir -p $out/share/gotosocial
        mv web $out/share/gotosocial/
      '';
    };
}
