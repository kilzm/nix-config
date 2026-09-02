return {
    "snacks.nvim",
    priority = 1000,
    lazy = false,
    after = function()
        require("snacks").setup({
            input = { enabled = true },
            picker = {
                enabled = true,
                git = true,
                layout = {
                    preset = "default",
                },
                formatters = {
                    file = {
                        filename_first = true,
                    },
                },
                win = {
                    input = {
                        keys = {
                            ["<Esc>"] = { "close", mode = { "n", "i" } },
                        },
                    },
                },
                sources = {
                    git_log = {
                        actions = {
                            diffview = function(picker)
                                local item = picker:current()
                                if not item or not item.commit then
                                    return
                                end
                                picker:close()
                                vim.cmd("DiffviewOpen " .. item.commit .. "~1.." .. item.commit)
                            end,
                        },
                        win = {
                            input = {
                                keys = {
                                    ["<C-l>"] = { "diffview", mode = { "n", "i" } },
                                },
                            },
                        },
                    },
                },
            },
            indent = {
                enabled = true,
                scope = { enabled = true },
            },
            notifier = {
                enabled = true,
            },
        })
    end,
    keys = {
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<leader>z",
            function()
                Snacks.zen()
            end,
            desc = "Toggle Zen Mode",
        },
        {
            "<leader>f",
            function()
                Snacks.picker.files()
            end,
            desc = "Search Files",
        },
        {
            "<leader>sk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Search Keymaps",
        },
        {
            "<leader>r",
            function()
                Snacks.picker.grep()
            end,
            desc = "Search by Grep",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Search current Word",
        },
        {
            "<leader>s<leader>",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Search existing buffers",
        },
        {
            "<leader>sa",
            function()
                Snacks.picker.help()
            end,
            desc = "Search Help",
        },
        {
            "<leader>sd",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Search Diagnostics",
        },
        {
            "<leader>sh",
            function()
                Snacks.picker.highlights()
            end,
            desc = "Search Highlights",
        },
        {
            "<leader>sc",
            function()
                Snacks.picker.colorschemes()
            end,
            desc = "Search Colorschemes",
        },
        {
            "<leader>sr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Search Recent Files",
        },
        {
            "<leader>s:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Search in Command History",
        },
        {
            "<leader>sm",
            function()
                Snacks.picker.marks()
            end,
            desc = "Search Marks",
        },
        {
            "gd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "gD",
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = "Goto Declaration",
        },
        {
            "gI",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementation",
        },
        {
            "gt",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto Type Definition",
        },
        {
            "<leader>ls",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP: Symbols",
        },
        {
            "<leader>lw",
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = "LSP: Workspace Symbols",
        },
        {
            "<leader>gb",
            function()
                Snacks.picker.git_branches()
            end,
            desc = "Git Branches",
        },
        {
            "<leader>gD",
            function()
                Snacks.picker.git_diff()
            end,
            desc = "Git Branches",
        },
        {
            "<leader>gl",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Git Log",
        },
        {
            "<leader>gf",
            function()
                Snacks.picker.git_log_file()
            end,
            desc = "Git Log File",
        },
        {
            "<leader>gs",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Git Status",
        },
        {
            "<leader>gS",
            function()
                Snacks.picker.git_stash()
            end,
            desc = "Git Stash",
        },
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse",
        },
        {
            "<leader>nh",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Notification History",
        },
        {
            "<leader>nd",
            function()
                Snacks.notifier.hide()
            end,
            desc = "Dismiss all Notifications",
        },
    },
}
