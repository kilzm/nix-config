{
  flake.homeModules.tmux = {
    config,
    pkgs,
    self',
    ...
  }: {
    programs.tmux = {
      enable = true;
      package = self'.packages.tmux;
    };

    home.packages = with pkgs; [
      tmux-sessionizer
    ];

    xdg.configFile."tms/config.toml".text = ''
      [[search_dirs]]
      path = "${config.home.homeDirectory}/projects"
      depth = 2

      [[search_dirs]]
      path = "${config.home.homeDirectory}/nix-config"
      depth = 1
    '';
  };
}
