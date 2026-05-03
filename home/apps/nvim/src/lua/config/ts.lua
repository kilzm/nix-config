local ts = require('nvim-treesitter')

ts.setup({
    auto_install = false,
})

local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Enable TreeSitter highlighting and indentation",
    callback = function(ev)
        local ft = ev.match

        local lang = vim.treesitter.language.get_lang(ft) or ft
        local buf = ev.buf
        pcall(vim.treesitter.start, buf, lang)

        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
