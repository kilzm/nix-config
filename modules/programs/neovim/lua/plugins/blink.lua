return {
    {
        "blink.cmp",
        lazy = false,
        after = function()
            require("blink.cmp").setup({
                completion = {
                    ghost_text = { enabled = true },
                    accept = {
                        auto_brackets = {
                            enabled = true,
                        },
                    },
                    documentation = {
                        auto_show = true,
                    },
                },
                snippets = {
                    preset = "luasnip",
                },
                sources = {
                    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                    providers = {
                        lazydev = {
                            name = "LazyDev",
                            module = "lazydev.integrations.blink",
                            score_offset = 100,
                        },
                    },
                },
                keymap = {
                    preset = "default",
                    ["<CR>"] = { "select_and_accept", "fallback" },
                    ["<Tab>"] = { "select_and_accept", "fallback" },
                    ["<C-j>"] = { "select_next", "fallback" },
                    ["<C-k>"] = { "select_prev", "fallback" },
                    ["<C-b>"] = { "scroll_documentation_up" },
                    ["<C-f>"] = { "scroll_documentation_down" },
                },
                signature = { enabled = true },
            })
        end,
    },
    {
        "luasnip",
        lazy = false,
        after = function()
            require("luasnip").config.setup()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
