{
  flake.nixosModules.editor = {self', ...}: {
    programs.neovim = {
      enable = true;
      package = self'.packages.neovim-minimal;
      defaultEditor = true;
    };
    programs.nano.enable = false;
  };
}
