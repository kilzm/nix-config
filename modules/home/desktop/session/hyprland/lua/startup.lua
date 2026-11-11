local values = require("lib.values")

hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XCURSOR_THEME", values.cursor_theme)
hl.env("XCURSOR_SIZE", values.cursor_size)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

local runtime_dir = os.getenv("XDG_RUNTIME_DIR")
if runtime_dir then
    hl.env("TMUX_TMPDIR", runtime_dir)
end

hl.on("hyprland.start", function()
    hl.exec_cmd("fluctus")
    hl.exec_cmd(
        'wl-paste -t text --watch clipman store -P --histpath="~/.local/share/clipman-primary.json"'
    )
end)
