local opts = { noremap = true, silent = true }
local function map(mode, lhs, rhs, desc)
    local o = desc and vim.tbl_extend("force", opts, { desc = desc }) or opts
    vim.keymap.set(mode, lhs, rhs, o)
end

-- splitting
map("n", "<leader>v", ":vsplit<CR>", "Split vertically")
map("n", "<leader>h", ":split<CR>", "Split horizontally")
map("n", "<A-h>", ":vertical resize -2<CR>")
map("n", "<A-l>", ":vertical resize +2<CR>")
map("n", "<A-k>", ":horizontal resize +2<CR>")
map("n", "<A-j>", ":horizontal resize -2<CR>")

-- visual
map(
    "v",
    "n",
    [[:<c-u>let temp_variable=@"<CR>gvy:<c-u>let @/='\V<C-R>=escape(@",'/\')<CR>'<CR>:let @"=temp_variable<CR>]]
)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "<", "<gv")
map("v", ">", ">gv")

-- motion
map("i", "jk", "<Esc>")
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>d", '"_d')
map("x", "<leader>p", '"_dP')
map("v", "r", '"_dp')

map("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>s", function()
    local word = vim.fn.expand("<cword>")
    local cmd = vim.keycode(":%s/\\<" .. word .. "\\>//gI" .. string.rep("<Left>", 3))
    vim.api.nvim_feedkeys(cmd, "n", false)
end, { desc = "Search and Replace" })
