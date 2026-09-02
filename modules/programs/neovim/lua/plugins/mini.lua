return {
    {
        "mini.nvim",
        lazy = false,
        after = function()
            require("mini.basics").setup()
            require("mini.icons").setup()
            require("mini.move").setup()
            require("mini.surround").setup()
            require("mini.pairs").setup()
            require("mini.operators").setup()
            require("mini.splitjoin").setup()
            require("mini.trailspace").setup()
            require("mini.git").setup()

            require("mini.keymap").map_multistep("i", "<S-Tab>", { "pmenu_next", "jump_after_tsnode" })

            require("mini.comment").setup({
                options = {
                    custom_commentstring = function()
                        if vim.bo.filetype == "vala" then
                            return "// %s"
                        end
                        if vim.bo.filetype == "blueprint" then
                            return "// %s"
                        end
                    end,
                },
            })

            require("mini.ai").setup({
                custom_textobjects = {
                    m = require("mini.ai").gen_spec.treesitter({
                        a = "@function.outer",
                        i = "@function.inner",
                    }),
                },
            })

            require("mini.bracketed").setup({
                file = { suffix = 'e', options = {} }
            })
            require("mini.ai").setup({
                custom_textobjects = {
                    m = MiniAi.gen_spec.treesitter({
                        a = "@function.outer",
                        i = "@function.inner",
                    }),
                },
            })

            require("mini.cursorword").setup({
                delay = 150,
            })

            require("mini.hipatterns").setup({
                highlighters = {
                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                },
            })

            require("mini.statusline").setup({
                use_icons = true,
                content = {
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                        local git = MiniStatusline.section_git({ trunc_width = 75 })
                        local diff = MiniStatusline.section_diff({ trunc_width = 75 })

                        local function location()
                            return " %l:%c "
                        end

                        return MiniStatusline.combine_groups({
                            {
                                hl = mode_hl,
                                strings = { mode },
                            },
                            { hl = "MiniStatuslineDevinfo", strings = { git, diff } },
                            "%<",
                            "%=",
                            { strings = { location() } },
                        })
                    end,
                },
            })

            require("mini.diff").setup({
                view = {
                    style = "sign",
                    signs = { add = "▎", change = "▎", delete = "▁" },
                },
                mappings = {
                    textobject = "ih",
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "ocaml", "rust", "sail" },
                callback = function(args)
                    vim.keymap.set("i", "'", "'", { buffer = args.buf })
                end,
            })
        end,
        keys = {
            {
                "<leader>gp",
                function()
                    require("mini.diff").toggle_overlay(0)
                end,
                desc = "Toggle Hunk Overlay",
            },
        },
    },
    {
        "mini.files",
        after = function()
            require("mini.files").setup({
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
