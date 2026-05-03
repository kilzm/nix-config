{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$scratch_term" = "^(scratch.term)$";
      "$scratch_yazi" = "^(scratch.yazi)$";
      "$scratch_qalc" = "^(scratch.qalc)$";
      "$scratch_waypaper" = "^(waypaper)$";
      "$scratch_spotify" = "^(spotify)$";
      "$scratch_resources" = "^(net.nokyan.Resources)$";
      "$scratch_networkmanager" = "^(nm-connection-editor)$";
      "$scratch_pwvucontrol" = "^(com.saivert.pwvucontrol)$";
      "$scratch_blueman" = "^(.blueman-manager-wrapped)$";

      bind = let
        scratchBind = {
          key,
          name,
          class,
          cmd,
        }: [
          "$shiftMod, ${key}, togglespecialworkspace, scratch_${name}"
          ''$shiftMod, ${key}, exec, if hyprctl clients | grep -q "${class}"; then echo "scratch.${name} respawn not needed"; else ${cmd}; hyprctl dispatch focuswindow class:${class}; fi''
        ];
      in
        builtins.concatLists [
          (scratchBind {
            key = "Q";
            name = "term";
            class = "scratch\\.term";
            cmd = "ghostty --class=scratch.term";
          })
          (scratchBind {
            key = "E";
            name = "yazi";
            class = "scratch\\.yazi";
            cmd = "ghostty --class=scratch.yazi -e yazi";
          })
          (scratchBind {
            key = "C";
            name = "qalc";
            class = "scratch\\.qalc";
            cmd = "ghostty --class=scratch.qalc -e qalc";
          })
          (scratchBind {
            key = "T";
            name = "resources";
            class = "resources";
            cmd = "resources";
          })
          (scratchBind {
            key = "A";
            name = "pwvucontrol";
            class = "pwvucontrol";
            cmd = "pwvucontrol";
          })
          (scratchBind {
            key = "B";
            name = "blueman";
            class = "blueman";
            cmd = "blueman-manager";
          })
          (scratchBind {
            key = "W";
            name = "waypaper";
            class = "waypaper";
            cmd = "waypaper";
          })
          (scratchBind {
            key = "S";
            name = "spotify";
            class = "spotify";
            cmd = "spotify";
          })
          (scratchBind {
            key = "N";
            name = "networkmanager";
            class = "nm-connection-editor";
            cmd = "nm-connection-editor";
          })
        ];

      windowrule = let
        scratchRule = name: "match:class ^(\$scratch_${name})$, float on, center on, size (monitor_w*0.8) (monitor_h*0.8), stay_focused on, focus on, workspace special:scratch_${name}";
      in
        map scratchRule [
          "term"
          "yazi"
          "qalc"
          "pwvucontrol"
          "resources"
          "blueman"
          "waypaper"
          "spotify"
          "networkmanager"
        ];
    };
  };
}
