return {
    "nvim-lspconfig",
    lazy = false,
    before = function()
        vim.diagnostic.config({ virtual_lines = { current_line = true } })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
                end

                if vim.lsp.inlay_hint then
                    vim.lsp.inlay_hint.enable(true, {})
                    map("<leader>li", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, "Toggle Inlay Hints")
                end

                map("<leader>lf", function()
                    vim.lsp.buf.format()
                end, "Format Code")
                map("<leader>lr", function()
                    vim.lsp.buf.rename()
                end, "Rename")
                map("<leader>lR", function()
                    vim.lsp.buf.references()
                end, "References")
                map("<leader>la", function()
                    vim.lsp.buf.code_action()
                end, "Code Action")
            end,
        })
    end,
}
