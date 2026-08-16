{
  flake.homeModules.hyprland = {config, ...}: {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      systemd = {
        enable = true;
        variables = ["--all"];
      };
      xwayland.enable = true;

      extraLuaFiles = {
        "conf.00-globals" = {
          content = ''
            mod = "SUPER"
            shell = "fluctus-request"
          '';
        };

        "lib.values" = {
          autoLoad = false;
          content = ''
            local M = {}

            M.cursor_theme = "${config.stylix.cursor.name}"
            M.cursor_size = "${toString config.stylix.cursor.size}"

            return M
          '';
        };

        "conf.config" = {content = ./lua/config.lua;};
        "conf.binds" = {content = ./lua/binds.lua;};
        "conf.animations" = {content = ./lua/animations.lua;};
        "conf.gestures" = {content = ./lua/gestures.lua;};
        "conf.rules" = {content = ./lua/rules.lua;};
        "conf.scratchpads" = {content = ./lua/scratchpads.lua;};
        "conf.startup" = {content = ./lua/startup.lua;};
      };
    };
  };
}
