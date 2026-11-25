{
  flake.homeModules.neovim = {
    self',
    config,
    pkgs,
    ...
  }: {
    programs.neovim = {
      enable = true;
      package = self'.packages.neovim;
    };

    xdg.dataFile."applications/nvim.desktop".source = pkgs.runCommandLocal "nvim.desktop" {} ''
      sed 's|^Icon=.*|Icon=nvim|' ${config.programs.neovim.finalPackage}/share/applications/nvim.desktop > $out
    '';
  };
}
