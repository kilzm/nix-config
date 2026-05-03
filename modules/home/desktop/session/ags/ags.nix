{
  flake.homeModules.ags = {self', ...}: {
    home.packages = [
      self'.packages.fluctus
    ];
  };
}
