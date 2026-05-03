{ self, pkgs, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      hinting = {
        enable = true;
        autohint = true;
      };
    };

    packages =
      (with pkgs; [
        freetype
        font-awesome
        inter
        iosevka
        roboto
        roboto-serif
        noto-fonts
        noto-fonts-cjk-sans
        cantarell-fonts
        overpass
        cozette
        corefonts
        vista-fonts
      ])
      ++ (with self.packages.${pkgs.stdenv.hostPlatform.system}; [
        google-sans-flex
      ])
      ++ (with pkgs.nerd-fonts; [
        fira-code
        droid-sans-mono
        # jetbrains-mono
        gohufont
        iosevka
        iosevka-term
        ubuntu
        ubuntu-mono
        ubuntu-sans
        hack
        sauce-code-pro
        fantasque-sans-mono
        mononoki
        monaspace
        space-mono
        zed-mono
      ]);
  };
}
