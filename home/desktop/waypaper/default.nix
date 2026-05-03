{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    waypaper
  ];
  xdg.configFile."waypaper/config.ini".text = ''
    [Settings]
    folder = ${config.home.homeDirectory}/nixos-config/wallpapers
    post_command = rm ~/.wallpaper; ln -sf $wallpaper ~/.wallpaper
    backend = awww
    awww_transition_type = grow
    awww_transition_fps = 60
  '';
}
