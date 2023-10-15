local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
require("lazy").setup({
	{'sainnhe/gruvbox-material', priority = 1000},

	{'ThePrimeagen/harpoon'},

	{'nvim-telescope/telescope.nvim', config = function()
		require('telescope').setup{
			defaults = {
				layout_config = {
					prompt_position = "top",
				},
				sorting_strategy = "ascending",
			},
		}
		require('telescope').load_extension('fzf')
		end,
		dependencies = {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}
	},

	{'nvim-lua/plenary.nvim'},

	{'alexghergh/nvim-tmux-navigation', event = "VeryLazy", config = function()
		require'nvim-tmux-navigation'.setup{}
		end
	},

	{'numToStr/Comment.nvim', event = "VeryLazy", config = function()
		require('Comment').setup()
		end
	},

	{'tpope/vim-fugitive', event = "VeryLazy"},
	{'tpope/vim-surround', event = "VeryLazy"},
	{'tpope/vim-rhubarb', event = "VeryLazy"},

	{'mbbill/undotree', event = "VeryLazy"},

	-- Debugger
	--
			{"rcarriga/nvim-dap-ui", commit = 'c020f66'},
	{"mfussenegger/nvim-dap",
		dependencies = {
			{'theHamsta/nvim-dap-virtual-text'},
			{'mfussenegger/nvim-dap-python'},
		},
	},

	{'nvim-lualine/lualine.nvim'},

	{'chentoast/marks.nvim', config = function()
		require'marks'.setup{force_write_shada = true}
		end
	},

	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
		require'nvim-treesitter.configs'.setup {
			ensure_installed = {"vim", "lua", "c", "python" },
			auto_install = true,
			highlight = {enable = true, additional_vim_regex_highlighting = false},
			indent = { enable = true },  
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-a>",
					node_incremental = "<c-a>",
				},
			},
		}
		end
	},
	{'stevearc/aerial.nvim', event = 'VeryLazy', config = function() 
		require('aerial').setup({ close_on_select = true, autojump = true })
		require('telescope').load_extension('aerial')
		end },
	{'nvim-tree/nvim-web-devicons', lazy = true},
	{'nvim-tree/nvim-tree.lua', config = function()
		require("nvim-tree").setup{diagnostics = {enable=true, show_on_dirs=true}}
		end
	},

	{'windwp/nvim-autopairs', event = "VeryLazy", config = function() 
		require("nvim-autopairs").setup({ignored_next_char = "[%w%.]", disable_filetype = {"TelescopePrompt"}})
	end},

	{'leosmaia21/gcompilecommands.nvim'},

	{'github/copilot.vim'},

	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x',
		dependencies = {
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-buffer'},
			{'honza/vim-snippets'},
			{'rafamadriz/friendly-snippets'},
		}
	},

	{'42Paris/42header'},
	{'vim-syntastic/syntastic', ft = 'c'},
	{'alexandregv/norminette-vim', ft = 'c'},
})

require('keymap')
require('debugger')
require('lualsp')
require('lualineconf')

vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = 'original'
vim.g.gruvbox_material_colors_override ={bg0 = {'#131919', '255'}, fg0 = {'#E1D6C3', '255'}}
vim.cmd.colorscheme('gruvbox-material')

vim.g.user42 = 'ledos-sa'
vim.g.mail42 = 'ledos-sa@student.42.fr'

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
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.hidden = true
vim.opt.undofile = true
vim.opt.foldlevel = 99
vim.opt.foldenable = false
vim.opt.mouse = ''
vim.opt.signcolumn = 'yes'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- local save = vim.api.nvim_create_augroup("SavePositionWhenLeaving", {clear = true})
-- vim.api.nvim_create_autocmd({"BufWrite"}, {
-- 	pattern = { "*" },
-- 	group = save,
-- 	callback = function()
-- 		if  vim.api.nvim_buf_get_option(0, 'buftype') == '' then
-- 			vim.cmd("silent! mkview")
-- 		end
-- 	end
-- })
-- vim.api.nvim_create_autocmd({"BufReadPost"}, {
-- 	pattern = { "*" },
-- 	group = save,
-- 	callback = function()
-- 		if  vim.api.nvim_buf_get_option(0, 'buftype') == '' then
-- 			vim.cmd("silent! loadview")
-- 		end
-- 	end
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup('yankcolor', {}),
	command = ("silent! lua vim.highlight.on_yank {higroup='IncSearch', timeout=100}")
})

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
