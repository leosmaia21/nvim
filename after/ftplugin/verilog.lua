vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.bo.commentstring = "// %s"

local opts = {buffer = 0,  noremap = true, silent = true }
vim.keymap.set('i', 'll', '<=', opts)
vim.keymap.set('n', '<leader>w', 'ialways @()<Esc>0==cib', opts)
