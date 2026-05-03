{
  flake.homeModules.wallpaper = {
    pkgs,
    config,
    lib,
    ...
  }: {
    home.packages = with pkgs; [
      waypaper
      awww
    ];

    home.file."wallpapers".source = ./wallpapers;

    xdg.configFile."waypaper/config.ini".text = lib.generators.toINI {} {
      Settings = {
        folder = "${config.home.homeDirectory}/wallpapers";
        post_command = "ln -sf $wallpaper ~/.wallpaper";
        backend = "awww";
        awww_transition_type = "grow";
        awww_transition_fps = 60;
      };
    };

    wayland.windowManager.hyprland.settings.exec-once = [
      "awww-daemon"
    ];
  };
}
