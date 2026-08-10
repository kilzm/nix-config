{
  flake.homeModules.opencode = {self', ...}: {
    programs.opencode = {
      enable = true;
      package = self'.packages.opencode;
    };
  };
}
