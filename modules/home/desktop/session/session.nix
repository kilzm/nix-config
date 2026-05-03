{self, ...}: {
  flake.homeModules.session = {
    imports = with self.homeModules; [
      ags
      hyprland
      hypridle
      hyprlock
      wallpaper
      hyprlock
      hyprsunset
    ];
  };
}
