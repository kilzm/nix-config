{
  flake.homeModules.hyprland = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = with pkgs; [
      hyprpicker
      grimblast
    ];

    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      "$filemanager" = "nautilus -w";
      "$browser" = "zen-beta";
      "$discord" = "vesktop";
      "$shell" = "fluctus-request";

      bind = [
        "$mod, R, exec, $shell toggle launcher"
        "$mod+SHIFT, Return, exec, $shell toggle launcher"
        "$mod, Escape, exec, $shell toggle powermenu"
        "$mod, Tab, exec, $shell toggle quicksettings"

        "$mod, Q, exec, $terminal"
        "$mod, Return, exec, $terminal"
        "$mod, E, exec, $filemanager"
        "$mod, B, exec, $browser"
        "$mod, D, exec, $discord"
        "$mod, bracketright, exec, hyprpicker -a"
        "$mod, Z, exec, hyprlock"
        "$mod, P, exec, grimblast --notify --freeze copy area"
        "$mod+SHIFT, P, exec, grimblast --notify --freeze copysave area"
        "$mod+CTRL, P, exec, grimblast --notify copy output"
        "$mod+SHIFT+CTRL, P, exec, grimblast --notify copysave output"

        "$mod, C, killactive"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating"
        "$mod, T, togglesplit"

        "$mod+CTRL, S, movetoworkspace, special"
        "$mod, S, togglespecialworkspace"

        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod+SHIFT, H, movewindow, l"
        "$mod+SHIFT, L, movewindow, r"
        "$mod+SHIFT, K, movewindow, u"
        "$mod+SHIFT, J, movewindow, d"

        "$mod+CTRL, H, resizeactive, -80 0"
        "$mod+CTRL, L, resizeactive, 80 0"
        "$mod+CTRL, K, resizeactive, 0 -80"
        "$mod+CTRL, J, resizeactive, 0 80"

        (
          lib.range 1 9
          |> map (n: let
            ws = toString n;
          in [
            "$mod, ${ws}, workspace, ${ws}"
            "$mod+SHIFT, ${ws}, movetoworkspace, ${ws}"
          ])
        )

        "$mod, minus, exec, hyprctl keyword cursor:zoom_factor 1"
        "$mod, equal, exec, hyprctl keyword cursor:zoom_factor 2"
        "$mod, backspace, exec, hyprctl keyword cursor:zoom_factor 4"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        ", XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ", XF86MonBrightnessUp,exec,brightnessctl set +5%"

        "CTRL, XF86AudioLowerVolume, exec, hyprctl hyprsunset temperature -500"
        "CTRL, XF86AudioRaiseVolume, exec, hyprctl hyprsunset temperature +500"
        "CTRL, XF86AudioMute, exec, hyprctl hyprsunset identity"
      ];
    };
  };
}
