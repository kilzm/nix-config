{
  flake.homeModules.shell = {self', ...}: {
    programs.fish = {
      enable = true;
      package = self'.packages.fish;
    };
    home.sessionVariables = {
      SHELL = "fish";
    };
    programs.zoxide.enable = true;
  };
}
