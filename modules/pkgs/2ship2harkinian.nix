let
  drv = {
    fetchurl,
    fetchzip,
    appimageTools,
    makeDesktopItem,
    makeWrapper,
  }: let
    pname = "2s2h";
    version = "4.0.2";

    desktopItem = makeDesktopItem {
      name = pname;
      exec = "2s2h";
      desktopName = "2 Ship 2 Harkinian";
      icon = fetchurl {
        url = "https://raw.githubusercontent.com/HarbourMasters/2ship2harkinian/${version}/mm/macosx/2s2hIcon.png";
        hash = "sha256-Mk2XvJgyT/YX+CZbASdZcNwmAOmWOTmGW/+lK0lGDwQ=";
      };
      categories = ["Game"];
    };
  in
    appimageTools.wrapType2 rec {
      inherit pname version;

      src = "${fetchzip {
        url = "https://github.com/HarbourMasters/2ship2harkinian/releases/download/${version}/2Ship-Keiichi-Charlie-Linux.zip";
        hash = "sha256-0Vi2F07HmcKuoE7G+mA7L9s+L/3Ku4qxYLnTUZFrGC0=";
        stripRoot = false;
      }}/2ship.appimage";

      nativeBuildInputs = [makeWrapper];

      extraInstallCommands = ''
        mkdir -p $out/share
        cp -v -r ${desktopItem}/share/applications $out/share

        wrapProgram $out/bin/2s2h\
          --run 'mkdir -p "$HOME/.local/share/2s2h"'\
          --run 'cd "$HOME/.local/share/2s2h"'
      '';

      meta = {
        downloadPage = "https://github.com/HarbourMasters/2ship2harkinian/releases";
        platforms = ["x86_64-linux"];
        mainProgram = "2s2h";
      };
    };
in {
  perSystem = {pkgs, ...}: {
    packages._2ship2harkinian = pkgs.callPackage drv {};
  };
}
