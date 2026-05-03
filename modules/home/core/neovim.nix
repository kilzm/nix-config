{
  flake.homeModules.neovim = {self', ...}: {
    programs.neovim = {
      enable = true;
      package = self'.packages.neovim;
    };
  };
}
