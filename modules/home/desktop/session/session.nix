{self, ...}: {
  flake.homeModules.session = {
    imports = with self.homeModules; [
      fluctus
      hyprland
      hypridle
      hyprlock
      wallpaper
      hyprlock
      hyprsunset
    ];
  };
}
