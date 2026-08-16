hl.config({ animations = { enabled = true } })

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("smooth", { type = "bezier", points = { { 0.05, 0.8 }, { 0.1, 1.0 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.8 }, { 0.1, 1.05 } } })
hl.curve("ease", { type = "bezier", points = { { 0.4, 0 }, { 0.6, 1.05 } } })

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 5,
    bezier = "overshot",
    style = "popin 30%",
})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 5,
    bezier = "overshot",
    style = "popin 30%",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 4,
    bezier = "overshot",
    style = "popin 50%",
})
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "ease" })
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "overshot",
    style = "slidefade 30%",
})
hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 6,
    bezier = "overshot",
    style = "slidefadevert -50%",
})
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "smooth" })
