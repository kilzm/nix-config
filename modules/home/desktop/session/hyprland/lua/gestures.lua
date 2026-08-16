hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "pinch", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "swipe", mods = "ALT", action = "resize" })

hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.exec_cmd(shell .. " toggle launcher")
    end,
})

hl.gesture({
    fingers = 3,
    direction = "left",
    mods = mod,
    action = function()
        hl.dispatch(hl.dsp.window.move({ workspace = "-1", follow = false }))
    end,
})

hl.gesture({
    fingers = 3,
    direction = "right",
    mods = mod,
    action = function()
        hl.dispatch(hl.dsp.window.move({ workspace = "+1", follow = false }))
    end,
})
