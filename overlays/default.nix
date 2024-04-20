{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      gotosocial =
        let
          web-assets = prev.fetchurl {
            url = "https://github.com/superseriousbusiness/gotosocial/releases/download/v0.15.0/gotosocial_0.15.0_web-assets.tar.gz";
            hash = "sha256-vrSdFIdBcfj6+sxtvv1s/Mu85I1mKxjyUYS902oLKk4=";
          };
        in
        prev.gotosocial.overrideAttrs {
          version = "0.15.0";
          doCheck = false;
          src = prev.fetchFromGitHub {
            owner = "superseriousbusiness";
            repo = "gotosocial";
            rev = "refs/tags/v0.15.0";
            hash = "sha256-z0iETddkw4C2R6ig9ZO8MTvhuWnmQ37/6q3oZ4WAzd4=";
          };
          postInstall = ''
            tar xf ${web-assets}
            mkdir -p $out/share/gotosocial
            mv web $out/share/gotosocial/
          '';
        };
    })
  ];
}
