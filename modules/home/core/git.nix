{
  flake.homeModules.git = {self', ...}: {
    programs.git = {
      enable = true;
      package = self'.packages.git;
    };

    stylix.targets.lazygit.enable = true;
    programs.lazygit.enable = true;
  };
}
