let
  drv = {
    lib,
    stdenvNoCC,
    fetchFromGitHub,
    gtk4,
  }:
    stdenvNoCC.mkDerivation {
      pname = "hatter-icon-theme";
      version = "0-unstable-2026-07-15";

      src = fetchFromGitHub {
        owner = "Mibea";
        repo = "Hatter";
        rev = "40776510270bf89f748f85ee9aa4c58eef1c1d52";
        hash = "sha256-gt21AHc3ceYT8T76FWUtx+NfDOeV48SU+23B982QId0=";
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
