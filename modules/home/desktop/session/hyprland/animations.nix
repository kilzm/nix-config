{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings.animations = {
      enabled = true;
      bezier = [
        "linear, 0, 0, 1, 1"
        "smooth, 0.05, 0.8, 0.1, 1.0"
        "overshot, 0.05, 0.8, 0.1, 1.05"
        "ease, 0.4, 0, 0.6, 1.05"
      ];

      animation = [
        "windows, 1, 5, overshot, popin 30%"
        "windowsIn, 1, 5, overshot, popin 30%"
        "windowsOut, 1, 4, overshot, popin 50%"
        "windowsMove, 1, 3, ease"

        "workspaces, 1, 6, overshot, slidefade 30%"
        "specialWorkspace, 1, 6, overshot, slidefadevert -50%"

        "layers, 1, 3, smooth"
        "fade, 1, 3, smooth"
      ];
    };
  };
}
