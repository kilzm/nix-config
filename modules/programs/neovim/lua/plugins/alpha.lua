return {
    "alpha-nvim",
    lazy = false,
    after = function()
        local hk = {
            "          ░▒███     ███░       ",
            "         ░▒▒█▓▒      ▒▒▓█░░     ",
            "       ░░▒██▓▓▓      ▓▓▓▓██░░   ",
            "       ░▒█▓▒░           ░▓█▒░   ",
            "       ░▒█▓▒░           ░▓█▒░   ",
            "       ░▒█▓▒▒          ░▒▓█▒░   ",
            "       ░▒██▓▓▒▒▒▒▒▒▒▒▒▒▓▓██░    ",
            "     ░░▒▒███████████████████▓░  ",
            "    ░░▒▓█████████████████████▓░ ",
            "   ░▒▒▓██████████████████████▓▒░",
            " ░ ░▒▓███████████████████████▓▒░",
            " ░ ░▒▓███████████    ███████  ▒▒",
            " ░ ░▒▓█████████        ████    ▒",
            "   ░░▒▓████████        ████    ▒",
            "     ░░▒▒▓███████    ███████  ▒ ",
            "       ░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒  ",
            "          ░░░░░░░░░░░░░░░░░░    ",
        }

        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.type = "group"
        dashboard.section.header.val = {
            {
                type = "text",
                val = hk,
                opts = { position = "center" },
            },
        }

        dashboard.section.buttons.val = {
            dashboard.button("f", " " .. " Find file", "<cmd>lua Snacks.picker.files()<cr>"),
            dashboard.button("n", " " .. " New file", "<cmd>ene <BAR> startinsert <cr>"),
            dashboard.button("r", " " .. " Recent files", "<cmd>lua Snacks.picker.recent()<cr>"),
            dashboard.button("g", " " .. " Find text", "<cmd>lua Snacks.picker.grep()<cr>"),
            dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
        }

        require("alpha").setup(dashboard.config)
    end,
}
