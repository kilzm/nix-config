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
            },
            indent = {
                enabled = true,
                scope = { enabled = true },
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
            "<leader>gl",
            function()
                Snacks.lazygit.log()
            end,
            desc = "Lazygit Logs",
        },
        {
            "<leader>z",
            function()
                Snacks.zen()
            end,
            desc = "Toggle Zen Mode",
        },
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Find Keymaps",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Find by Grep",
        },
        {
            "<leader>fw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Find current Word",
        },
        {
            "<leader>f<leader>",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Find existing buffers",
        },
        {
            "<leader>fa",
            function()
                Snacks.picker.help()
            end,
            desc = "Find Help",
        },
        {
            "<leader>fd",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Find Diagnostics",
        },
        {
            "<leader>fh",
            function()
                Snacks.picker.highlights()
            end,
            desc = "Find Highlights",
        },
        {
            "<leader>fc",
            function()
                Snacks.picker.colorschemes()
            end,
            desc = "Find Colorschemes",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Find Recent Files",
        },
        {
            "<leader>f:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Find in Command History",
        },
        {
            "<leader>fm",
            function()
                Snacks.picker.marks()
            end,
            desc = "Find Marks",
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
            "<leader>gd",
            function()
                Snacks.picker.git_diff()
            end,
            desc = "Git Diff",
        },
        {
            "<leader>gL",
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
