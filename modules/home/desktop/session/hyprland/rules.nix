{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      layerrule = [
        "match:namespace ags:.*, blur on, ignore_alpha 0.6"
        "match:namespace ags:launcher, animation popin 50%"
        "match:namespace ags:powermenu, animation popin 50%"
        "match:namespace ags:verification, animation popin 50%"
        "match:namespace ags:osd, animation slide bottom"
        "match:namespace ags:notification-popups, animation slide right"
        "match:namespace ags:quicksettings, animation slide right"
      ];

      windowrule = [
      ];
    };
  };
}
