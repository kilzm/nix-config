{
  flake.nixosModules.core = {self', ...}: {
    environment.systemPackages = [
      self'.packages.cli-env
    ];
  };
}
