vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

local opts = { noremap = true, silent = true }

vim.keymap.set('i', 'll', '<=', opts)
vim.keymap.set('n', '<leader>w', 'ialways @()<Esc>0==cib', opts)
