return {
    "flash.nvim",
    after = function()
        require("flash").setup()
    end,
    keys = {
        {
            "S",
            function()
                require("flash").jump()
            end,
            desc = "Flash Jump",
        },
        {
            "S",
            function()
                require("flash").jump()
            end,
            desc = "Flash Jump",
            mode = "x",
        },
        {
            "S",
            function()
                require("flash").jump()
            end,
            desc = "Flash Jump",
            mode = "o",
        },
        {
            "<A-s>",
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "<A-s>",
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
            mode = "x",
        },
        {
            "<A-s>",
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
            mode = "o",
        },
        {
            "r",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
            mode = "o",
        },
        {
            "R",
            function()
                require("flash").treesitter_search()
            end,
            desc = "Flash Treesitter Search",
            mode = "o",
        },
        {
            "R",
            function()
                require("flash").treesitter_search()
            end,
            desc = "Flash Treesitter Search",
            mode = "x",
        },
        {
            "<C-s>",
            function()
                require("flash").toggle()
            end,
            desc = "Toggle Flash",
            mode = "c",
        },
    },
}
