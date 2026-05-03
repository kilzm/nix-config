{
  flake.homeModules.hyprland = {
    pkgs,
    lib,
    ...
  }: {
    wayland.windowManager.hyprland.settings = let
      scratch = {
        term = rec {
          key = "Q";
          class = "scratch.term";
          cmd = "ghostty --class=${class}";
        };
        yazi = rec {
          key = "E";
          class = "scratch.yazi";
          cmd = "ghostty --class=${class} -e yazi";
        };
        qalc = rec {
          key = "C";
          class = "scratch.qalc";
          cmd = "ghostty --class=${class} -e qalc";
        };
        wlctl = rec {
          key = "N";
          class = "scratch.wlctl";
          cmd = "ghostty --class=${class} -e wlctl";
        };
        bluetui = rec {
          key = "B";
          class = "scratch.bluetui";
          cmd = "ghostty --class=${class} -e bluetui";
        };
        waypaper = {
          key = "W";
          class = "waypaper";
          cmd = "waypaper";
        };
        spotify = {
          key = "S";
          class = "spotify";
          cmd = "spotify";
        };
        pwvucontrol = {
          key = "A";
          class = "com.saivert.pwvucontrol";
          cmd = "pwvucontrol";
        };
        resources = {
          key = "T";
          class = "net.nokyan.Resources";
          cmd = "resources";
        };
      };

      scratchBind = name: s: let
        scratch-toggle =
          pkgs.writeShellScriptBin "scratch-toggle-${name}"
          # bash
          ''
            if ! hyprctl clients | grep -q "${s.class}"; then
              ${s.cmd} &
              hyprctl dispatch togglespecialworkspace scratch_${name}
              for i in $(seq 1 20); do
                hyprctl clients | grep -q "${s.class}" && break
                sleep 0.1
              done
              sleep 0.1
              hyprctl dispatch focuswindow class:${s.class}
            else
              hyprctl dispatch togglespecialworkspace scratch_${name}
            fi
          '';
      in [
        "$mod+SHIFT, ${s.key}, exec, ${lib.getExe scratch-toggle}"
      ];
    in {
      bind = builtins.concatLists (lib.mapAttrsToList scratchBind scratch);

      windowrule =
        lib.mapAttrsToList (
          name: s: "match:class ^(${s.class})$, float on, center on, size (monitor_w*0.8) (monitor_h*0.8), stay_focused on, workspace special:scratch_${name}"
        )
        scratch;
    };
  };
}
