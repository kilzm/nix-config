{
  flake.homeModules.gnome = {config, ...}: let
    c = config.lib.stylix.colors;
    a = toString config.stylix.opacity.applications;
    border = toString (1.0 - config.stylix.opacity.applications);
    translucent = "rgba(${c.base01-rgb-r}, ${c.base01-rgb-g}, ${c.base01-rgb-b}, ${a})";
  in {
    stylix.targets.gnome.enable = true;
    stylix.targets.gtk = {
      enable = true;
      extraCss = ''
        @define-color sidebar_border_color alpha(@window_fg_color, ${border});
        @define-color secondary_sidebar_border_color alpha(@window_fg_color, ${border});
        @define-color headerbar_border_color @window_fg_color;
        window.background:root {
          background-color: ${translucent};
          backdrop-filter: blur(20px);
        }
        .sidebar-pane {
          background-color: transparent;
        }
        .content-pane,
        overlay-split-view > widget:not(.sidebar-pane):not(.background) > toolbarview {
          background-color: @view_bg_color;
        }
        .sidebar-pane toolbarview > .top-bar,
        .sidebar-pane toolbarview > .bottom-bar {
          background-color: transparent;
        }
      '';
    };
  };
}
