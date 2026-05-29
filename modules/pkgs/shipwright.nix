let
  drv = {
    fetchurl,
    fetchzip,
    appimageTools,
    makeDesktopItem,
    makeWrapper,
  }: let
    pname = "soh";
    version = "9.2.3";

    desktopItem = makeDesktopItem {
      name = pname;
      exec = "soh";
      desktopName = "Ship of Harkinian";
      icon = fetchurl {
        url = "https://raw.githubusercontent.com/HarbourMasters/Shipwright/${version}/soh/macosx/sohIcon.png";
        hash = "sha256-M//KmohmKXALzpLzNNPUYNpI9BshlIVMAoDeo/ZFGFA=";
      };
      categories = ["Game"];
    };
  in
    appimageTools.wrapType2 rec {
      inherit pname version;

      src = "${fetchzip {
        url = "https://github.com/HarbourMasters/Shipwright/releases/download/${version}/SoH-Ackbar-Delta-Linux.zip";
        hash = "sha256-hlu5j8ZI+oml2xgnbQRh+a+lMC1hsZMyN4cExilIa7g=";
        stripRoot = false;
      }}/soh.appimage";

      nativeBuildInputs = [makeWrapper];

      extraInstallCommands = ''
        mkdir -p $out/share
        cp -v -r ${desktopItem}/share/applications $out/share

        wrapProgram $out/bin/soh\
          --run 'mkdir -p "$HOME/.local/share/soh"'\
          --run 'cd "$HOME/.local/share/soh"'
      '';

      meta = {
        homepage = "https://www.shipofharkinian.com/";
        downloadPage = "https://github.com/HarbourMasters/Shipwright/releases";
        platforms = ["x86_64-linux"];
        mainProgram = "soh";
      };
    };
in {
  perSystem = {pkgs, ...}: {
    packages.shipwright = pkgs.callPackage drv {};
  };
}
