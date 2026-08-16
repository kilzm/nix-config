hl.config({
    general = {
        layout = "dwindle",
        gaps_in = 8,
        gaps_out = { top = 10, right = 16, bottom = 16, left = 16 },
        border_size = 1,
        col = {
            active_border = "rgba(68,68,68,0.6)",
            inactive_border = "rgba(40,40,40,0.6)",
        },
    },

    dwindle = {
        force_split = 0,
        special_scale_factor = 0.8,
        split_width_multiplier = 1.0,
        use_active_for_splits = true,
        preserve_split = true,
    },

    input = {
        kb_layout = "us(altgr-intl)",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.3,
            drag_lock = true,
            tap_to_click = true,
            tap_and_drag = true,
        },
    },

    decoration = {
        rounding = 12,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 1,
            color = "#00000033",
        },
        blur = {
            enabled = true,
            ignore_opacity = true,
            size = 10,
            passes = 4,
            popups = true,
            noise = 0.015,
            vibrancy = 0.5,
            vibrancy_darkness = 2.0,
        },
    },

    cursor = {
        no_hardware_cursors = true,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})
