{
  flake.nixosModules.fonts = {pkgs, ...}: {
    fonts.fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      hinting = {
        enable = true;
        autohint = true;
      };
    };

    stylix.targets.font-packages.enable = true;
    stylix.targets.fontconfig.enable = true;

    stylix.fonts = rec {
      sansSerif = {
        package = pkgs.adwaita-fonts;
        name = "Adwaita Sans";
      };

      serif = sansSerif;

      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    fonts.packages =
      (with pkgs; [
        freetype
        font-awesome
        inter
        roboto
        noto-fonts
        noto-fonts-cjk-sans
        corefonts
        vista-fonts
      ])
      ++ (with pkgs.nerd-fonts; [
        jetbrains-mono
        iosevka
        ubuntu
        monaspace
      ]);
  };
}
