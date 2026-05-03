{
  flake.homeModules.core = {
    pkgs,
    self',
    ...
  }: {
    home.packages =
      [
        self'.packages.cli-env
      ]
      ++ (with pkgs; [
        microfetch
      ]);
  };
}
