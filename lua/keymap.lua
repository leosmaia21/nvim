local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, opts)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, opts)
vim.keymap.set('n', '<leader>d',  require('telescope.builtin').diagnostics, opts)
vim.keymap.set('n', '<leader>of', require('telescope.builtin').oldfiles, opts)
vim.keymap.set('n', '<leader>qf', require('telescope.builtin').quickfix, opts)
vim.keymap.set('n', '<leader>m',  require('telescope.builtin').marks, opts)
vim.keymap.set('n', '<leader>fg', function()
	local string = vim.fn.input("Grep > ")
	if string ~= '' then builtin.grep_string({ search = string }) end
end, opts)

vim.api.nvim_create_user_command('Delmarks',function() vim.cmd("delm!") vim.cmd("wshada!") end, {})

vim.keymap.set('n', '<leader>a', function() require("harpoon.mark").add_file() end, opts)
vim.keymap.set('n', '<leader>h', function() require("harpoon.ui").toggle_quick_menu()end,  opts)
vim.keymap.set('n', '<A-1>', 	 function() require("harpoon.ui").nav_file(1) end, opts)
vim.keymap.set('n', '<A-2>', 	 function() require("harpoon.ui").nav_file(2) end, opts)
vim.keymap.set('n', '<A-3>', 	 function() require("harpoon.ui").nav_file(3) end, opts)
vim.keymap.set('n', '<A-4>', 	 function() require("harpoon.ui").nav_file(4) end, opts)
vim.keymap.set('n', '<A-5>', 	 function() require("harpoon.ui").nav_file(5) end, opts)
vim.keymap.set('n', '<A-6>', 	 function() require("harpoon.ui").nav_file(6) end, opts)
vim.keymap.set('n', '<A-7>', 	 function() require("harpoon.ui").nav_file(7) end, opts)
vim.keymap.set('n', '<A-8>', 	 function() require("harpoon.ui").nav_file(8) end, opts)
vim.keymap.set('n', '<A-9>', 	 function() require("harpoon.ui").nav_file(9) end, opts)
-- Move to previous/next
vim.keymap.set('n', '<A-l>', 	 function() require("harpoon.ui").nav_next() end, opts)
vim.keymap.set('n', '<A-h>', 	 function() require("harpoon.ui").nav_prev() end, opts)


vim.keymap.set('n', '<leader>j', "d3o", opts)
vim.keymap.set('n', '<leader>f', "d2o", opts)

-- vim.keymap.set('n', '<C-w>', '<C-w>w')
local nvim_tmux_nav = require('nvim-tmux-navigation')
vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
vim.keymap.set('n', '<C-Right>', '<C-w>l')
vim.keymap.set('n', '<C-Up>', '<C-w>k')
vim.keymap.set('n', '<C-Left>', '<C-w>h')
vim.keymap.set('n', '<C-Down>', '<C-w>j')

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<leader>s', "<cmd> Telescope aerial<CR>", opts)

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

vim.keymap.set('i', '<C-H>', '<C-W>', opts)

vim.keymap.set('n', '<A-c>', '<Cmd>copen<CR>')
vim.keymap.set('n', '<A-j>', '<Cmd>cnext<CR>zz')
vim.keymap.set('n', '<A-k>', '<Cmd>cprevious<CR>zz')

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-Space>', [[<C-\><C-n><C-W>w]])

vim.keymap.set({'n', 't'}, '<F5>', "<Cmd>lua require'dap'.continue()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F6>', "<Cmd>lua require'dap'.step_over()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F4>', "<Cmd>lua require'dap'.terminate()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F7>', "<Cmd>lua require'dap'.step_into()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F8>', "<Cmd>lua require'dap'.step_out()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F9>', "<Cmd>lua require'dap'.run_last()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F10>', "<Cmd>lua require'dap'.run_to_cursor()<CR>", opts)
vim.keymap.set({'n', 't'}, '<Leader>b', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set({'n', 't'}, '<Leader>B', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.keymap.set({'n', 't'}, '<Leader>lp', "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)

--disable arrow keys
vim.keymap.set({'n', 'v'}, '<Up>',    function() print("Nope!") end)
vim.keymap.set({'n', 'v'}, '<Down>',  function() print("Nope!") end)
vim.keymap.set({'n', 'v'}, '<Left>',  function() print("Nope!") end)
vim.keymap.set({'n', 'v'}, '<Right>', function() print("Nope!") end)
