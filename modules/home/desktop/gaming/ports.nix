{
  flake.homeModules.gaming = {
    pkgs,
    self',
    ...
  }: {
    home.packages = [
      pkgs.dusklight
      self'.packages.shipwright
      self'.packages._2ship2harkinian
    ];
  };
}
