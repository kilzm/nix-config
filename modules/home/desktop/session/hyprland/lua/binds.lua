local terminal = "ghostty"
local filemanager = "nautilus -w"
local browser = "zen-beta"
local discord = "discord"

hl.bind(mod .. " + R", hl.dsp.exec_cmd(shell .. " toggle launcher"))
hl.bind(mod .. " + SHIFT + Return", hl.dsp.exec_cmd(shell .. " toggle launcher"))
hl.bind(mod .. " + Escape", hl.dsp.exec_cmd(shell .. " toggle powermenu"))
hl.bind(mod .. " + Tab", hl.dsp.exec_cmd(shell .. " toggle quicksettings"))

hl.bind(mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(filemanager))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + D", hl.dsp.exec_cmd(discord))
hl.bind(mod .. " + bracketright", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mod .. " + Z", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + P", hl.dsp.exec_cmd("grimblast --notify --freeze copy area"))
hl.bind(mod .. " + SHIFT + P", hl.dsp.exec_cmd("grimblast --notify --freeze copysave area"))
hl.bind(mod .. " + CTRL + P", hl.dsp.exec_cmd("grimblast --notify copy output"))
hl.bind(mod .. " + SHIFT + CTRL + P", hl.dsp.exec_cmd("grimblast --notify copysave output"))

hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + V", hl.dsp.window.float())
hl.bind(mod .. " + T", hl.dsp.layout("togglesplit"))

hl.bind(mod .. " + CTRL + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("special"))

hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))

hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

hl.bind(mod .. " + CTRL + H", hl.dsp.window.resize({ x = -80, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + L", hl.dsp.window.resize({ x = 80, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -80, relative = true }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 80, relative = true }))

for i = 1, 9 do
    local ws = tostring(i)
    hl.bind(mod .. " + " .. ws, hl.dsp.focus({ workspace = ws }))
    hl.bind(mod .. " + SHIFT + " .. ws, hl.dsp.window.move({ workspace = ws }))
end

hl.bind(mod .. " + minus", function()
    hl.config({ cursor = { zoom_factor = 1 } })
end)
hl.bind(mod .. " + equal", function()
    hl.config({ cursor = { zoom_factor = 2 } })
end)
hl.bind(mod .. " + backspace", function()
    hl.config({ cursor = { zoom_factor = 4 } })
end)

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"),
    { repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-"),
    { repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { repeating = true }
)

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true })

hl.bind(
    "CTRL + XF86AudioLowerVolume",
    hl.dsp.exec_cmd("hyprctl hyprsunset temperature -500"),
    { repeating = true }
)
hl.bind(
    "CTRL + XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("hyprctl hyprsunset temperature +500"),
    { repeating = true }
)
hl.bind(
    "CTRL + XF86AudioMute",
    hl.dsp.exec_cmd("hyprctl hyprsunset identity"),
    { repeating = true }
)
