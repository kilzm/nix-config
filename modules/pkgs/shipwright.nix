let
  drv = {
    fetchurl,
    appimageTools,
    makeDesktopItem,
    makeWrapper,
  }: let
    pname = "soh";
    version = "9.3.1";

    description = "PC port of Ocarina of Time with modern controls, widescreen, high-resolution, and more";

    desktopItem = makeDesktopItem {
      name = pname;
      exec = "soh";
      desktopName = "Ship of Harkinian";
      comment = description;
      icon = fetchurl {
        url = "https://raw.githubusercontent.com/HarbourMasters/Shipwright/${version}/soh/macosx/sohIcon.png";
        hash = "sha256-M//KmohmKXALzpLzNNPUYNpI9BshlIVMAoDeo/ZFGFA=";
      };
      categories = ["Game"];
    };
  in
    appimageTools.wrapType2 rec {
      inherit pname version;

      src = fetchurl {
        url = "https://github.com/HarbourMasters/Shipwright/releases/download/${version}/SoH-Dewey-Bravo.appimage";
        hash = "sha256-5Lt3XJoMNinrrFfktsy6bQtiHXGrIB6RBazu+RQa0fQ=";
      };

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
        inherit description;
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
