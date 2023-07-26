local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<leader>d', builtin.diagnostics, opts)
vim.keymap.set('n', '<leader>of', builtin.oldfiles, opts)
vim.keymap.set('n', '<leader>qf', builtin.quickfix, opts)
vim.keymap.set('n', '<leader>fg', function()
	local string = vim.fn.input("Grep > ")
	if string ~= '' then
		builtin.grep_string({ search = string })
	end
end, opts)

vim.keymap.set('n', '<leader>a', function() require("harpoon.mark").add_file() end, opts)
vim.keymap.set('n', '<leader>h', function() require("harpoon.ui").toggle_quick_menu()end,  opts)
vim.keymap.set('n', '<A-1>', function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set('n', '<A-2>', function() require("harpoon.ui").nav_file(2) end)
vim.keymap.set('n', '<A-3>', function() require("harpoon.ui").nav_file(3) end)
vim.keymap.set('n', '<A-4>', function() require("harpoon.ui").nav_file(4) end)
vim.keymap.set('n', '<A-5>', function() require("harpoon.ui").nav_file(5) end)
vim.keymap.set('n', '<A-6>', function() require("harpoon.ui").nav_file(6) end)
vim.keymap.set('n', '<A-7>', function() require("harpoon.ui").nav_file(7) end)
vim.keymap.set('n', '<A-8>', function() require("harpoon.ui").nav_file(8) end)
vim.keymap.set('n', '<A-9>', function() require("harpoon.ui").nav_file(9) end)
-- Move to previous/next
vim.keymap.set('n', '<A-l>', function() require("harpoon.ui").nav_next() end, opts)
vim.keymap.set('n', '<A-h>', function() require("harpoon.ui").nav_prev() end, opts)

vim.keymap.set('n', '<C-w>', '<C-w>w')
vim.keymap.set('n', '<C-Right>', '<C-w>l')
vim.keymap.set('n', '<C-Up>', '<C-w>k')
vim.keymap.set('n', '<C-Left>', '<C-w>h')
vim.keymap.set('n', '<C-Down>', '<C-w>j')

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>')

vim.keymap.set('n', '<leader><Tab>', '<C-6>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('v', "<S-Tab>", "<gv")
vim.keymap.set('v', "<Tab>", ">gv")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')

vim.keymap.set('n', '<C-k>', '{')
vim.keymap.set('n', '<C-j>', '}')

vim.keymap.set('i', 'jj', '<Esc>', opts)

vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true})

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-W>w]])

vim.keymap.set({'n', 't'}, '<F5>', function() if startDebugger() == 1 then require'dap'.continue() end end, opts)
-- vim.keymap.set({'n', 't'}, '<F5>', "<Cmd>lua require'dap'.continue()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F6>', "<Cmd>lua require'dap'.step_over()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F4>', "<Cmd>lua require'dap'.terminate()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F7>', "<Cmd>lua require'dap'.step_into()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F8>', "<Cmd>lua require'dap'.step_out()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F9>', "<Cmd>lua require'dap'.run_last()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F10>', "<Cmd>lua require'dap'.run_to_cursor()<CR>", opts)
vim.keymap.set({'n', 't'}, '<Leader>b', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set({'n', 't'}, '<Leader>B', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.keymap.set({'n', 't'}, '<Leader>lp', "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
