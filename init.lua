-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
	vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'sainnhe/gruvbox-material'
	use 'ThePrimeagen/harpoon'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'alexghergh/nvim-tmux-navigation'
	use 'numToStr/Comment.nvim'
	use 'tpope/vim-surround'
	use 'mbbill/undotree'
	use "mfussenegger/nvim-dap"
	use "rcarriga/nvim-dap-ui"
	use 'mfussenegger/nvim-dap-python'
	use 'theHamsta/nvim-dap-virtual-text'
	use 'nvim-lualine/lualine.nvim'
	use 'chentoast/marks.nvim'
	use {'nvim-treesitter/nvim-treesitter', run = function() 
		local ts_update = require('nvim-treesitter.install').update({ with_sync = true }) ts_update() end}
	use 'nvim-tree/nvim-web-devicons'
	use 'nvim-tree/nvim-tree.lua'
	use 'windwp/nvim-autopairs'
	use 'github/copilot.vim'
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim', run = function() pcall(vim.cmd, 'MasonUpdate') end},
			{'williamboman/mason-lspconfig.nvim'}, -- Optional
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
			{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-buffer'},
		}
	}
	use {'42Paris/42header'}
	use {'vim-syntastic/syntastic'}
	use {'alexandregv/norminette-vim'}
	if is_bootstrap then
		require('packer').sync()
	end
end)

if is_bootstrap then
	print '=================================='
	print '    Plugins are being installed'
	print '    Wait until Packer completes,'
	print '       then restart nvim'
	print '=================================='
	return
end

vim.g.user42 = 'ledos-sa'
vim.g.mail42 = 'ledos-sa@student.42.fr'

vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_foreground = 'original'
vim.g.gruvbox_material_colors_override ={bg0 = {'#181919', '255'}}
vim.cmd.colorscheme('gruvbox-material')

vim.g.mapleader = " "
vim.g.termdebug_popup = 0
vim.g.termdebug_wide = 1
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.scrolloff = 5
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.hidden = true
vim.opt.undofile = true
vim.opt.foldlevel = 99
vim.opt.foldenable = false
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup('yankcolor', {}),
	command = ("silent! lua vim.highlight.on_yank {higroup='IncSearch', timeout=100}")
})

require('keymap')
require('lualsp')
require('debugger')
require('lualineconf')

require('Comment').setup()
require'marks'.setup{force_write_shada = true}

require("nvim-autopairs").setup({ignored_next_char = "[%w%.]", disable_filetype = {"TelescopePrompt"}})

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"vim", "lua", "c", "python" },
	auto_install = true,
	-- indent = {
	-- 	enable = true,
	-- },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

require("nvim-tree").setup{diagnostics = {enable=true, show_on_dirs=true}}

local save = vim.api.nvim_create_augroup("SavePositionWhenLeaving", {clear = true})
vim.api.nvim_create_autocmd({"BufWrite"}, {
	pattern = { "*" },
	command = "silent! mkview",
	group = save,
})
vim.api.nvim_create_autocmd({"BufReadPost"}, {
	pattern = { "*" },
	command = "silent! loadview",
	group = save,
})

-- Automatically source and re-compile packer whenever you save this init.lua
vim.api.nvim_create_autocmd('BufWritePost', {
	command = 'source <afile> | PackerCompile',
	group = vim.api.nvim_create_augroup('Packer', { clear = true }),
	pattern = vim.fn.expand '$MYVIMRC',
})

require'nvim-tmux-navigation'.setup{}

vim.api.nvim_create_user_command('Norm', function()
	vim.g.syntastic_c_checkers = {'norminette'}
	vim.g.syntastic_aggregate_errors = 1
	vim.g.syntastic_c_norminette_exec = 'norminette'
	vim.g.c_syntax_for_h = 1
	vim.g.syntastic_c_include_dirs = {'include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include'}
	vim.g.syntastic_c_norminette_args = '-R CheckTopCommentHeader'
	vim.g.syntastic_check_on_open = 1
	vim.g.syntastic_always_populate_loc_list = 1
	vim.g.syntastic_auto_loc_list = 0
	vim.g.syntastic_check_on_wq = 0
	vim.cmd('write')
end, {})

