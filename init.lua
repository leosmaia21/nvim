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
	use 'ellisonleao/gruvbox.nvim'
	use 'sainnhe/gruvbox-material'
	use 'ThePrimeagen/harpoon'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim'
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
			{'saadparwaiz1/cmp_luasnip'},
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
-- GRUVBOX
require("gruvbox").setup({
contrast = "hard",
bold = false,
strikethrough = true,
palette_overrides = {
	dark0_hard = "#181919",
}
})

vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_colors_override ={
	 bg0 = {'#181919', '255'},
	 fg0 = {'#ebdbb2', '255'},
	 red = {'#fb4934', '255'},
	 green = {'#b8bb26', '255'},
	 yellow = {'#fabd2f', '255'},
	 orange = {'#fe8019', '255'}
	 
}
vim.cmd.colorscheme('gruvbox-material')

vim.g.mapleader = " "
vim.g.termdebug_popup = 0
vim.g.termdebug_wide = 1
vim.opt.termguicolors = true
vim.opt.rnu = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.scrolloff = 5
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.ignorecase = true
vim.opt.hidden = true
vim.opt.undofile = true
vim.opt.foldlevel = 99
vim.opt.foldenable = false
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup('yankcolor', {}),
	command = ("silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=100 }")
})

require('keymap')
require('lualsp')
require('debugger')


require('Comment').setup()
require'marks'.setup{force_write_shada = true}
local maxSizeFile = 5
require("lualine").setup{
	options = {
		icons_enabled = true,
		component_separators = "|",
		section_separators = "",
		refresh = {statusline = 250},
	},
	sections = { 
		lualine_a = {function()
			local currentFile = vim.fn.split(vim.api.nvim_buf_get_name(0), "/")
			currentFile = currentFile[#currentFile]
			if vim.api.nvim_buf_get_option(0, 'buftype') == '' then
				local lenSize = string.len(currentFile)
				if (lenSize > maxSizeFile) then maxSizeFile = lenSize end
				if (maxSizeFile % 2 == 0) then maxSizeFile = maxSizeFile + 1 end
				local padding = math.floor((maxSizeFile - lenSize) / 2)
				if lenSize % 2 == 0 then currentFile = currentFile .. " " end
				padding = string.rep(" ", padding)
				return padding .. currentFile .. padding
			else
				return currentFile
			end
			end,
			function()
				if vim.api.nvim_buf_get_option(0, 'buftype') == ''  then
					for i, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_get_option(buf, 'buftype') == ''  then
							if vim.api.nvim_buf_get_option(buf,'modified') then
								return 'Unsaved files' -- any message or icon
							end
						end
					end
					return ''
				else
					return ''
				end
			end,
		},
		lualine_b = {{ 'diagnostics', sources = { 'nvim_lsp' }}, 
			function() 
				if vim.api.nvim_buf_get_option(0, 'buftype') == ''  then
					local tabela = require("harpoon").get_mark_config()['marks']
					local ret = ""
					local currentFile = vim.fn.split(vim.api.nvim_buf_get_name(0), "/")
					currentFile = currentFile[#currentFile]
					for key, value in pairs(tabela) do
						file = vim.fn.split(value['filename'], "/")
						file = file[#file]
						if file == currentFile then file = file .. "*" else file = file .. " " end 
						ret = ret .. "  " ..  key .. " " .. file
					end
					return ret
				else
					return ''
				end
		end},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	}
}

require("nvim-autopairs").setup({
	ignored_next_char = "[%w%.]",
	disable_filetype = { "TelescopePrompt" },
})

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"vim", "lua", "c", "python" },
	auto_install = true,
	indent = {
		enable = true,
	},
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

local norminette = 0
vim.api.nvim_create_user_command('Norm', function()
	norminette = (norminette == 0) and 1 or 0
	vim.g.syntastic_c_checkers = {'norminette'}
	vim.g.syntastic_aggregate_errors = norminette
	vim.g.syntastic_c_norminette_exec = 'norminette'
	vim.g.c_syntax_for_h = norminette
	vim.g.syntastic_c_include_dirs = {'include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include'}
	vim.g.syntastic_c_norminette_args = '-R CheckTopCommentHeader'
	vim.g.syntastic_check_on_open = norminette
	vim.g.syntastic_always_populate_loc_list = norminette
	vim.g.syntastic_auto_loc_list = 0
	vim.g.syntastic_check_on_wq = 0
	vim.cmd('write')
end, {})
