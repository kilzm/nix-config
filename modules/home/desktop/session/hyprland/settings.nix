{
  flake.homeModules.hyprland = {config, ...}: {
    wayland.windowManager.hyprland.settings = {
      general = {
        layout = "dwindle";
        gaps_in = 8;
        gaps_out = "10, 16, 16, 16";
        border_size = 1;
        "col.active_border" = "rgba(68,68,68,0.6)";
        "col.inactive_border" = "rgba(40,40,40,0.6)";
      };

      dwindle = {
        force_split = 0;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = true;
        preserve_split = true;
      };

      input = {
        kb_layout = "us(altgr-intl)";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.3;
          drag_lock = true;
          tap-to-click = true;
          tap-and-drag = true;
        };
      };

      decoration = {
        rounding = 12;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 1;
          color = "rgba(00000033)";
        };
        blur = {
          enabled = true;
          ignore_opacity = true;
          size = 10;
          passes = 4;
          contrast = 1.0;
          brightness = 1.0;
          popups = true;
          noise = 0.015;
        };
      };

      env = [
        "XDG_SESSION_TYPE,wayland"
        "XCURSOR_THEME,${config.stylix.cursor.name}"
        "XCURSOR_SIZE,${toString config.stylix.cursor.size}"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];

      cursor = {
        no_hardware_cursors = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      exec-once = [
        "fluctus"
        ''wl-paste -t text --watch clipman store -P --histpath="~/.local/share/clipman-primary.json"''
      ];
    };
  };
}
