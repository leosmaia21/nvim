local opts = { noremap = true, silent = true }
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', 	telescope.find_files, opts)
vim.keymap.set('n', '<C-p>', 		telescope.find_files, opts)
-- vim.keymap.set('n', '<leader>gf', 	telescope.git_files, opts)
vim.keymap.set('n', '<C-b>', 		telescope.buffers, opts)
vim.keymap.set('n', '<leader>d',  	telescope.diagnostics, opts)
vim.keymap.set('n', '<leader>o', 	telescope.oldfiles, opts)
vim.keymap.set('n', '<leader>q', 	telescope.quickfix, opts)
vim.keymap.set('n', '<leader>m',  	telescope.marks, opts)
vim.keymap.set('n', '<leader>g', function()
	local str = vim.fn.input("Grep> ")
	if str ~= '' then
		vim.cmd("silent! grep -rIi " .. str .. " * ")
		telescope.quickfix()
	end
end, opts)

vim.api.nvim_create_user_command('Delmarks',function() vim.cmd("delm!") vim.cmd("wshada!") end, {})

vim.cmd("cnoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'")

vim.keymap.set('n', '<leader>a', function() require("harpoon.mark").add_file() end, opts)
vim.keymap.set('n', '<leader>h', function() require("harpoon.ui").toggle_quick_menu()end,  opts)
for i = 1, 9 do
	vim.keymap.set('n', '<A-'..i..'>', function() require("harpoon.ui").nav_file(i) end, opts)
	vim.keymap.set('n', '<leader>'..i, function() require("harpoon.ui").nav_file(i) end, opts)
end
vim.keymap.set('n', '<A-l>', 	 function() require("harpoon.ui").nav_next() end, opts)
vim.keymap.set('n', '<A-h>', 	 function() require("harpoon.ui").nav_prev() end, opts)

-- vim.keymap.set('n', '<C-Space>', '<C-w>w')
vim.keymap.set('n', '<C-Space>', require('nvim-tmux-navigation').NvimTmuxNavigateNext, opts)
vim.keymap.set('n', '<Up>', '<C-w>k', opts)
vim.keymap.set('n', '<Right>', '<C-w>l', opts)
vim.keymap.set('n', '<Left>', '<C-w>h', opts)
vim.keymap.set('n', '<Down>', '<C-w>j', opts)

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, opts)

vim.keymap.set('n', '<leader>s', "<cmd>Telescope aerial<CR>", opts)

vim.keymap.set('n', '<CR>', 'ciw', opts)

vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle, opts)
vim.keymap.set('n', '<C-e>', "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)

vim.keymap.set('n', '<leader><Tab>', '<C-6>', opts)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

vim.keymap.set('v', '<S-Tab>', "<gv", opts)
vim.keymap.set('v', '<Tab>', ">gv", opts)

vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', opts)

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
vim.keymap.set({'n'}, '<Leader>k', "<Cmd>lua require('dap.ui.widgets').hover()<CR>", opts)
