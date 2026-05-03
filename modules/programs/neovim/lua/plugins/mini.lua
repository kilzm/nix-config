return {
    {
        "mini.nvim",
        lazy = false,
        after = function()
            require("mini.icons").setup()
            require("mini.ai").setup()
            require("mini.surround").setup()
            require("mini.pairs").setup()
            require("mini.operators").setup()
            require("mini.splitjoin").setup()
            require("mini.comment").setup()
            require("mini.hipatterns").setup()
            require("mini.bracketed").setup()
            require("mini.cursorword").setup()

            MiniAi.setup({
                custom_textobjects = {
                    m = MiniAi.gen_spec.treesitter(
                        { a = "@function.outer", i = "@function.inner" },
                        {}
                    ),
                },
            })

            MiniCursorword.setup({
                delay = 150,
            })

            MiniHipatterns.setup({
                highlighters = {
                    hex_color = MiniHipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },
    {
        "mini.files",
        after = function()
            require("mini.files").setup()

            MiniFiles.setup({
                windows = {
                    preview = true,
                    width_focus = 30,
                    width_nofocus = 20,
                    width_preview = 80,
                    max_number = 4,
                },
            })
        end,
        keys = {
            {
                "<leader>e",
                function()
                    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
                end,
                desc = "Open Mini Files",
            },
            {
                "<leader>E",
                function()
                    MiniFiles.open(nil, false)
                end,
                desc = "Open Mini Files",
            },
        },
    },
}
