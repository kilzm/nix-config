return {
    {
        "nvim-treesitter",
        lazy = false,
        after = function()
            require("nvim-treesitter").setup({
                auto_install = false,
            })

            local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                desc = "Enable TreeSitter highlighting and indentation",
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
                    local buf = ev.buf
                    pcall(vim.treesitter.start, buf, lang)

                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr"
                end,
            })
        end,
    },
    {
        "nvim-treesitter-textobjects",
        lazy = false,
        after = function()
            require("nvim-treesitter-textobjects").setup({
                move = {
                    set_jumps = true,
                },
            })
        end,
        keys = {
            {
                "]f",
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
                end,
                mode = { "n", "x", "o" },
                desc = "Next function start",
            },
            {
                "[f",
                function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
                end,
                mode = { "n", "x", "o" },
                desc = "Previous function start",
            },
            {
                "]F",
                function()
                    require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
                end,
                mode = { "n", "x", "o" },
                desc = "Next function end",
            },
            {
                "[F",
                function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
                end,
                mode = { "n", "x", "o" },
                desc = "Previous function end",
            },
        }
    }
}
