let
  drv = {
    lib,
    stdenvNoCC,
    fetchFromGitHub,
    gtk4,
  }:
    stdenvNoCC.mkDerivation {
      pname = "hatter-icon-theme";
      version = "0-unstable-2026-10-21";

      src = fetchFromGitHub {
        owner = "Mibea";
        repo = "Hatter";
        rev = "877aa2ade75ce799f21a0a2dc014b4307e26f7a9";
        hash = "sha256-7XPUI/ZfR6Kgg83kJWIPIqKlqTDkf3USzfABiD6RPoo=";
      };

      nativeBuildInputs = [gtk4];

      dontDropIconThemeCache = true;
      dontCheckForBrokenSymlinks = true;

      installPhase = ''
        runHook preInstall

        mkdir -p $out/share/icons
        for theme in Hatter Hatter-Blue Hatter-Green Hatter-Orange Hatter-Pink \
                     Hatter-Purple Hatter-Red Hatter-Slate Hatter-Teal \
                     Hatter-Yellow Hatter-Yaru; do
          cp -r "$theme" "$out/share/icons/$theme"
        done

        ln -s ausweisapp.svg "$out/share/icons/Hatter/scalable/apps/AusweisApp.svg"
        ln -s ImHex.svg "$out/share/icons/Hatter/scalable/apps/imhex.svg"

        for d in $out/share/icons/*/; do
          gtk4-update-icon-cache -f -t "$d" || true
        done

        runHook postInstall
      '';

      meta = {
        description = "Hatter icon theme — rounded-square icons preserving each app's identity";
        homepage = "https://github.com/Mibea/Hatter";
        license = lib.licenses.gpl3Plus;
        platforms = lib.platforms.linux;
      };
    };
in {
  perSystem = {pkgs, ...}: {
    packages.hatter-icon-theme = pkgs.callPackage drv {};
  };
}
