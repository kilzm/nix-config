let
  drv = {
    lib,
    stdenv,
    fetchurl,
  }:
    stdenv.mkDerivation {
      pname = "google-sans-flex";
      version = "1.0";

      src = fetchurl {
        url = "https://raw.githubusercontent.com/hgggy7777/Google-Sans-Flex/1.0.0/GoogleSansFlex-Regular.ttf";
        hash = "sha256-ei4n2YMzNygHJiie5YADyqasdxxJj6d3bjdVWgW04jo=";
      };

      dontUnpack = true;

      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp $src $out/share/fonts/truetype/GoogleSansFlex-Regular.ttf
      '';

      meta = with lib; {
        description = "Google Sans Flex variable font";
        homepage = "https://fonts.google.com/specimen/Google+Sans+Flex";
        license = licenses.ofl;
        platforms = platforms.all;
      };
    };
in {
  perSystem = {pkgs, ...}: {
    packages.google-sans-flex = pkgs.callPackage drv {};
  };
}
