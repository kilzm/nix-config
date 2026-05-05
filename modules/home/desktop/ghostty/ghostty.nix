{
  flake.homeModules.ghostty = {
    config,
    lib,
    pkgs,
    ...
  }: {
    home = {
      packages = [(pkgs.writeShellScriptBin "xterm" "${lib.getExe pkgs.ghostty} $@")];
      sessionVariables = {TERMINAL = "ghostty";};
    };

    programs.ghostty = {
      enable = true;
      settings = {
        theme = "Nordfox";
        background = "#${config.lib.stylix.colors.base00}";
        background-opacity = config.stylix.opacity.terminal;
        font-family = config.stylix.fonts.monospace.name;
        font-size = lib.mkDefault 13;
        window-padding-x = 12;
        window-padding-y = 6;
        adjust-cell-height = "40%";

        command = "fish";
        shell-integration = "fish";
        shell-integration-features = "no-cursor";
        cursor-style = "bar";
        gtk-single-instance = true;
        window-decoration = false;
        confirm-close-surface = false;
        mouse-scroll-multiplier = 1;
        mouse-hide-while-typing = true;

        custom-shader = ["${./shaders/cursor_warp.glsl}"];

        keybind = [
          "ctrl+enter=unbind"
        ];
      };
    };
  };
}
