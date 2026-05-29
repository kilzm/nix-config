{
  flake.homeModules.shell = {self', lib, ...}: {
    programs.fish = {
      enable = true;
      package = self'.packages.fish;
    };
    home.sessionVariables = {
      SHELL = lib.getExe self'.packages.fish;
    };
    programs.zoxide.enable = true;
  };
}
