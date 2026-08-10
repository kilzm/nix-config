{
  flake.homeModules.gaming = {
    self',
    inputs',
    ...
  }: {
    home.packages = [
      inputs'.dusklight.packages.default
      self'.packages.shipwright
      self'.packages._2ship2harkinian
    ];
  };
}
