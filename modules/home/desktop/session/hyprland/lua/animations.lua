hl.config({ animations = { enabled = true } })

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("ease", { type = "bezier", points = { { 0.4, 0 }, { 0.6, 1.05 } } })

hl.curve("snappy", { type = "spring", mass = 1, stiffness = 260, damping = 25.5 })
hl.curve("settle", { type = "spring", mass = 1, stiffness = 260, damping = 27 })

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 2,
    spring = "snappy",
    style = "popin 50%",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 2,
    bezier = "linear",
    style = "popin 50%",
})
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, spring = "settle" })
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 2,
    spring = "snappy",
    style = "fade",
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 2,
    bezier = "linear",
    style = "fade",
})
hl.animation({ leaf = "fade", enabled = true, speed = 2.5, bezier = "ease" })
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 3,
    spring = "settle",
    style = "slide",
})
hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 2,
    spring = "settle",
    style = "slidevert -100%",
})
hl.animation({
    leaf = "specialWorkspaceOut",
    enabled = true,
    speed = 2,
    spring = "settle",
    style = "slidevert -100%",
})
