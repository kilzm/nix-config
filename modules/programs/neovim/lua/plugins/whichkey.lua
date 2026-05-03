return {
    "which-key.nvim",
    lazy = false,
    after = function()
        require("which-key").setup({
            notify = false,
            icons = {
                mappings = false,
            },
            preset = "modern",
        })

        require("which-key").add({
            { "<leader>f", desc = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>gh", group = "Hunk" },
            { "<leader>l", group = "Lsp" },
            { "<leader>d", group = "Debug" },
            { "<leader>n", group = "Notifications" },
            { "<leader>P", hidden = true },
            { "<leader>Y", hidden = true },
            { "<leader>p", hidden = true },
            { "<leader>y", hidden = true },
        })
    end,
}
