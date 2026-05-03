{
  flake.nixosModules.shell = {self', ...}: {
    programs.fish = {
      enable = true;
      package = self'.packages.fish;
    };
  };
}
