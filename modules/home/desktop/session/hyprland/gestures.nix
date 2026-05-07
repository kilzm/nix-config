{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      gesture = [
        "3, horizontal, workspace"
        "3, pinch, fullscreen"
        "3, swipe, mod: ALT, resize"
        "3, up, dispatcher, exec, $shell toggle launcher"
        "3, left, mod: $mod, dispatcher, movetoworkspacesilent, -1"
        "3, right, mod: $mod, dispatcher, movetoworkspacesilent, +1"
      ];
    };
  };
}
