return {
    "nightfox.nvim",
    lazy = false,
    after = function()
        local function brighten(hex, factor)
            hex = hex:gsub("#", "")

            local r = tonumber(hex:sub(1, 2), 16)
            local g = tonumber(hex:sub(3, 4), 16)
            local b = tonumber(hex:sub(5, 6), 16)

            r = math.min(255, r * factor)
            g = math.min(255, g * factor)
            b = math.min(255, b * factor)

            local function toHex(value)
                return string.format("%02x", math.floor(value))
            end

            return "#" .. toHex(r) .. toHex(g) .. toHex(b)
        end

        local background = "#141414"
        local foreground = "#f0f0f0"

        local palette = require("nightfox.palette").load("nordfox")

        require("nightfox").setup({
            options = {
                transparent = true,
                styles = {
                    comments = "italic",
                },
            },
            palettes = {
                all = {
                    bg0 = brighten(background, 0.9),
                    bg1 = background,
                    bg2 = brighten(background, 1.2),
                    bg3 = brighten(background, 1.4),
                    bg4 = brighten(background, 1.6),

                    fg1 = foreground,

                    sel0 = brighten(background, 2.6),
                    sel1 = brighten(background, 3.2),
                },
            },
            groups = {
                all = {
                    WinBar = { bg = "none", fg = "fg2" },
                    WinBarNC = { bg = "none", fg = "fg2" },
                    WinSeparator = { fg = "bg3" },
                    StatusLine = { bg = "bg2" },
                    StatusLineNC = { bg = "bg2" },
                    Pmenu = { bg = "bg2" },
                    NormalFloat = { bg = "bg2", fg = "fg" },
                    FloatTitle = { bg = "bg2" },
                    FloatFooter = { bg = "bg2" },
                    FloatBorder = { fg = "bg2", bg = "bg2" },
                    LspFloatWinNormal = { bg = "bg4" },
                    BlinkCmpDoc = { bg = "bg2", fg = "fg" },
                    BlinkCmpDocBorder = { bg = "bg2", fg = "bg2" },
                    BlinkCmpDocSeparator = { bg = "bg2", fg = "sel0" },
                    MiniFilesBorderModified = { bg = "bg2", fg = "sel0" },
                    MiniFilesTitle = { link = "NormalFloat" },
                    MiniFilesTitleFocused = { link = "NormalFloat" },
                    MiniFilesCursorLine = { bg = "sel0" },
                    NonText = { fg = "sel1" },
                    EndOfBuffer = { fg = "sel0" },
                    LspInlayHint = { bg = "none", fg = "sel1" },
                    LspReferenceText = { bg = "bg4" },
                    SnacksIndent = { fg = "bg4" },
                    SnacksIndentScope = { fg = "sel1" },
                    SnacksNotifierHistory = { link = "NormalFloat" },
                    SnacksTitle = { bg = palette.black.bright },
                    SnacksPickerTitle = { bg = "bg2", fg = "sel1" },
                    SnacksPickerListCursorLine = { bg = "sel0", fg = "fg1" },
                },
            },
        })

        vim.cmd("colorscheme nordfox")

        vim.api.nvim_set_hl(0, "WinBar", { bold = false })
        vim.api.nvim_set_hl(0, "WinBarNC", { bold = false })
    end,
}
