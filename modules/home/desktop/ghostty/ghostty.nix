{
  flake.homeModules.ghostty = {
    config,
    lib,
    pkgs,
    ...
  }: {
    home.packages = [(pkgs.writeShellScriptBin "xterm" "${lib.getExe pkgs.ghostty} $@")];

    stylix.targets.ghostty.enable = true;
    programs.ghostty = {
      enable = true;
      settings = {
        theme = lib.mkForce "Nordfox";
        background = lib.mkForce "#${config.lib.stylix.colors.base00}";
        background-opacity = config.stylix.opacity.terminal;
        font-size = lib.mkForce 13;
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

        custom-shader = ["${./shaders/cursor_warp.glsl}"];

        keybind = [
          "ctrl+enter=unbind"
        ];
      };
    };
  };
}
