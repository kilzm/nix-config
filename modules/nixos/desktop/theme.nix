{
  flake.nixosModules.desktop = {pkgs, ...}: {
    stylix = {
      icons = {
        enable = true;
        package = pkgs.morewaita-icon-theme;
        light = "MoreWaita";
        dark = "MoreWaita";
      };

      cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-dark";
        size = 24;
      };
    };
  };
}
