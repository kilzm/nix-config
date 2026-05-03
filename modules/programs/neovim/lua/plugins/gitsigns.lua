return {
    "gitsigns.nvim",
    after = function()
        require("gitsigns").setup()
    end,
    keys = {
        { "<leader>ghp", require("gitsigns").preview_hunk, desc = "Preview Hunk" },
        { "<leader>ghs", require("gitsigns").stage_hunk, desc = "Stage Hunk" },
        { "<leader>ghr", require("gitsigns").reset_hunk, desc = "Reset Hunk" },
        { "<leader>gt", require("gitsigns").toggle_current_line_blame, desc = "Toggle Line Blame" },
    },
}
