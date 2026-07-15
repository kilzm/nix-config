{
  flake.nixosModules.desktop = {pkgs, self', ...}: {
    stylix = {
      icons = {
        enable = true;
        package = self'.packages.hatter-icon-theme;
        light = "Hatter";
        dark = "Hatter";
      };

      cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-dark";
        size = 24;
      };

      targets = {
        qt.enable = true;
        gtk.enable = true;
      };
    };
  };
}
