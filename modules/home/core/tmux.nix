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

    xdg.configFile."tms/config.toml".source = (pkgs.formats.toml {}).generate "config.toml" {
      search_dirs = [
        {
          path = "${config.home.homeDirectory}/projects";
          depth = 2;
        }
        {
          path = "${config.home.homeDirectory}/nix-config";
          depth = 1;
        }
      ];
    };
  };
}
