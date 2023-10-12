local opts = { noremap = true, silent = true }
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, opts)
vim.keymap.set('n', '<leader>gf', telescope.git_files, opts)
vim.keymap.set('n', '<leader>fb', telescope.buffers, opts)
vim.keymap.set('n', '<leader>d',  telescope.diagnostics, opts)
vim.keymap.set('n', '<leader>of', telescope.oldfiles, opts)
vim.keymap.set('n', '<leader>qf', telescope.quickfix, opts)
vim.keymap.set('n', '<leader>m',  telescope.marks, opts)
vim.keymap.set('n', '<leader>fg', function()
	local str = vim.fn.input("Grep> ")
	if str ~= '' then 
		vim.cmd("silent! grep -rIi " .. str .. " * ")
		telescope.quickfix()
	end
end, opts)

vim.api.nvim_create_user_command('Delmarks',function() vim.cmd("delm!") vim.cmd("wshada!") end, {})

local harpoonUI = require("harpoon.ui")
local harpoonMark = require("harpoon.mark")
vim.keymap.set('n', '<leader>a', function() harpoonMark.add_file() end, opts)
vim.keymap.set('n', '<leader>h', function() harpoonUI.toggle_quick_menu()end,  opts)
vim.keymap.set('n', '<A-1>', 	 function() harpoonUI.nav_file(1) end, opts)
vim.keymap.set('n', '<A-2>', 	 function() harpoonUI.nav_file(2) end, opts)
vim.keymap.set('n', '<A-3>', 	 function() harpoonUI.nav_file(3) end, opts)
vim.keymap.set('n', '<A-4>', 	 function() harpoonUI.nav_file(4) end, opts)
vim.keymap.set('n', '<A-5>', 	 function() harpoonUI.nav_file(5) end, opts)
vim.keymap.set('n', '<A-6>', 	 function() harpoonUI.nav_file(6) end, opts)
vim.keymap.set('n', '<A-7>', 	 function() harpoonUI.nav_file(7) end, opts)
vim.keymap.set('n', '<A-8>', 	 function() harpoonUI.nav_file(8) end, opts)
vim.keymap.set('n', '<A-9>', 	 function() harpoonUI.nav_file(9) end, opts)
vim.keymap.set('n', '<A-l>', 	 function() harpoonUI.nav_next() end, opts)
vim.keymap.set('n', '<A-h>', 	 function() harpoonUI.nav_prev() end, opts)


vim.keymap.set('n', '<leader>1', "d2o", opts)
vim.keymap.set('n', '<leader>2', "d3o", opts)

-- vim.keymap.set('n', '<C-w>', '<C-w>w')
local nvim_tmux_nav = require('nvim-tmux-navigation')
vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext, opts)
vim.keymap.set('n', '<C-Right>', '<C-w>l', opts)
vim.keymap.set('n', '<C-Up>', '<C-w>k', opts)
vim.keymap.set('n', '<C-Left>', '<C-w>h', opts)
vim.keymap.set('n', '<C-Down>', '<C-w>j', opts)

vim.keymap.set('n', '<leader>gs', vim.cmd.Git, opts)

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, opts)

vim.keymap.set('n', '<leader>s', "<cmd> Telescope aerial<CR>", opts)

vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', opts)

vim.keymap.set('n', '<leader><Tab>', '<C-6>', opts)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

vim.keymap.set('v', "<S-Tab>", "<gv", opts)
vim.keymap.set('v', "<Tab>", ">gv", opts)

vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>p', '"+p', opts)

vim.keymap.set('n', '<C-k>', '{', opts)
vim.keymap.set('n', '<C-j>', '}', opts)

vim.keymap.set('i', 'jj', '<Esc>', opts)

vim.keymap.set('i', '<C-H>', '<C-W>', opts)

vim.keymap.set('n', '<A-c>', '<Cmd>copen<CR>')
vim.keymap.set('n', '<A-j>', '<Cmd>cnext<CR>zz', opts)
vim.keymap.set('n', '<A-k>', '<Cmd>cprevious<CR>zz', opts)

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
vim.keymap.set('t', '<C-Space>', [[<C-\><C-n><C-W>w]], opts)

vim.keymap.set({'n', 't'}, '<F5>', "<Cmd>lua require'dap'.continue()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F6>', "<Cmd>lua require'dap'.step_over()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F4>', "<Cmd>lua require'dap'.terminate()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F3>', "<Cmd>lua require'dapui'.toggle()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F7>', "<Cmd>lua require'dap'.step_into()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F8>', "<Cmd>lua require'dap'.step_out()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F9>', "<Cmd>lua require'dap'.run_last()<CR>", opts)
vim.keymap.set({'n', 't'}, '<F10>', "<Cmd>lua require'dap'.run_to_cursor()<CR>", opts)
vim.keymap.set({'n'}, '<Leader>b', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set({'n'}, '<Leader>B', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.keymap.set({'n'}, '<Leader>lp', "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)

--disable arrow keys
vim.keymap.set({'n', 'v'}, '<Up>',    function() print("Nope!") end, opts)
vim.keymap.set({'n', 'v'}, '<Down>',  function() print("Nope!") end, opts)
vim.keymap.set({'n', 'v'}, '<Left>',  function() print("Nope!") end, opts)
vim.keymap.set({'n', 'v'}, '<Right>', function() print("Nope!") end, opts)
