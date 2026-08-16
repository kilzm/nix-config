local function spawn_or_toggle(name, class, cmd)
    if #hl.get_windows({ class = class }) > 0 then
        hl.dispatch(hl.dsp.workspace.toggle_special("scratch_" .. name))
        return
    end

    hl.exec_cmd(cmd)
    hl.dispatch(hl.dsp.workspace.toggle_special("scratch_" .. name))

    local timer
    timer = hl.timer(function()
        local wins = hl.get_windows({ class = class })
        if #wins > 0 then
            timer:set_enabled(false)
            hl.dispatch(hl.dsp.focus({ window = wins[1] }))
        end
    end, { timeout = 100, type = "repeat" })
end

local scratchpads = {
    {
        name = "term",
        key = "Q",
        class = "scratch.term",
        cmd = "ghostty --class=scratch.term",
    },
    {
        name = "btop",
        key = "T",
        class = "scratch.btop",
        cmd = "ghostty --class=scratch.btop -e btop",
    },
    {
        name = "yazi",
        key = "E",
        class = "scratch.yazi",
        cmd = "ghostty --class=scratch.yazi -e yazi",
    },
    {
        name = "qalc",
        key = "C",
        class = "scratch.qalc",
        cmd = "ghostty --class=scratch.qalc -e qalc",
    },
    {
        name = "wlctl",
        key = "N",
        class = "scratch.wlctl",
        cmd = "ghostty --class=scratch.wlctl -e wlctl",
    },
    {
        name = "bluetui",
        key = "B",
        class = "scratch.bluetui",
        cmd = "ghostty --class=scratch.bluetui -e bluetui",
    },
    { name = "waypaper", key = "W", class = "waypaper", cmd = "waypaper" },
    { name = "spotify", key = "S", class = "spotify", cmd = "spotify" },
    { name = "pwvucontrol", key = "A", class = "com.saivert.pwvucontrol", cmd = "pwvucontrol" },
}

for _, s in ipairs(scratchpads) do
    hl.bind(mod .. " + SHIFT + " .. s.key, function()
        spawn_or_toggle(s.name, s.class, s.cmd)
    end)

    hl.window_rule({
        match = { class = "^" .. s.class .. "$" },
        float = true,
        center = true,
        size = "monitor_w*0.8 monitor_h*0.8",
        stay_focused = true,
        workspace = "special:scratch_" .. s.name,
    })
end
