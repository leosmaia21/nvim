local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

vim.g.tabNumber = 4
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
require("lazy").setup({
	-- {'sainnhe/gruvbox-material', priority = 1000},
	{'rose-pine/neovim', name = 'rose-pine'},
	{'ThePrimeagen/harpoon'},
	{'nvim-telescope/telescope.nvim', event = "VeryLazy", config = function()
		require('telescope').setup{defaults = {
			layout_config = {prompt_position = "top"},
			sorting_strategy = "ascending"
			}
		}
		require('telescope').load_extension('fzf')
		require('keymap')
	end,
		dependencies = {{'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
	}},

	{'nvim-lua/plenary.nvim'},

	{'alexghergh/nvim-tmux-navigation', event = "VeryLazy", config = function()
		require'nvim-tmux-navigation'.setup{} end },

	{'numToStr/Comment.nvim', event = "VeryLazy", config = function()
		require('Comment').setup() end },

	{'mg979/vim-visual-multi', event = "VeryLazy"},

	{'tpope/vim-fugitive', event = "VeryLazy"},
	-- {'tpope/vim-rhubarb', event = "VeryLazy"},
	{'kylechui/nvim-surround', event = "VeryLazy", version = "*", config = function()
		require("nvim-surround").setup() end },

	{'mbbill/undotree', event = "VeryLazy"},

	{'mfussenegger/nvim-dap', lazy = true},
	{'theHamsta/nvim-dap-virtual-text', lazy = true},
	{"rcarriga/nvim-dap-ui", lazy = true},
	{'mfussenegger/nvim-dap-python', lazy = true},

	{'nvim-lualine/lualine.nvim'},

	{'chentoast/marks.nvim', event = "VeryLazy", config = function() require'marks'.setup{force_write_shada = true} end },

	{'lukas-reineke/indent-blankline.nvim', event = "VeryLazy",
		main = 'ibl', config = function()
			require"ibl".setup{
				indent = {char = "│"},
				scope = {enabled = false},
		} end
	},

	{'nvim-treesitter/nvim-treesitter', build = ":TSUpdate", config = function()
		require'nvim-treesitter.configs'.setup {
			-- ensure_installed = {"vim", "lua", "c", "python" },
			auto_install = true,
			highlight = {enable = true, additional_vim_regex_highlighting = false},
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {init_selection = "<c-a>", node_incremental = "<c-a>"},
			},
		}
	end
	},

	-- {'stevearc/aerial.nvim', event = 'VeryLazy', config = function()
	-- 	require('aerial').setup({ close_on_select = true, autojump = true })
	-- 	require('telescope').load_extension('aerial')
	-- end },

	{'nvim-tree/nvim-web-devicons', event = "VeryLazy"},

	-- {'nvim-tree/nvim-tree.lua', event = "VeryLazy", config = function()
	-- 	require("nvim-tree").setup{
	-- 		diagnostics = {enable=false}
	-- 	}
	-- end
	-- },

	{'stevearc/oil.nvim', config = function()
		require("oil").setup({
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["<C-v>"] = "actions.select_vsplit",
				["<C-x>"] = "actions.select_split",
				["<BS>"] = "actions.parent",
			},
			view_options = {
				is_hidden_file = function(name, bufnr)
					return name == ".." and false or vim.startswith(name, ".")
				end,
			}
		})
	end},

	{'windwp/nvim-autopairs', event = "VeryLazy", config = function()
		require("nvim-autopairs").setup({ignored_next_char = "[%w%.]", disable_filetype = {"TelescopePrompt"}})
	end},

	{'neovim/nvim-lspconfig',
		dependencies = {
		{'williamboman/mason.nvim'},
		{'williamboman/mason-lspconfig.nvim'},
		{'hrsh7th/nvim-cmp'},
		{'hrsh7th/cmp-nvim-lsp'},
		{'L3MON4D3/LuaSnip'},
		{'saadparwaiz1/cmp_luasnip'},
		{'hrsh7th/cmp-path'},
		{'hrsh7th/cmp-buffer'}
		},
	config = function()
		require('lualsp')
	end
	},

	{'42Paris/42header', ft = 'c'},
	{'vim-syntastic/syntastic', ft = 'c'},
	{'alexandregv/norminette-vim', ft = 'c'},
})

-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_winsize = 25
-- vim.g.gruvbox_material_better_performance = 1
-- vim.g.gruvbox_material_background = "hard"
-- vim.g.gruvbox_material_foreground = 'mix'
-- vim.g.gruvbox_material_colors_override ={bg0 = {'#131919', '255'}, fg0 = {'#E1D6C3', '255'}}
-- vim.cmd.colorscheme('gruvbox-material')
require('rose-pine').setup({
    styles = {
        bold = false,
        italic = false,
	},
})
vim.cmd.colorscheme('rose-pine')

require('debugger')
require('lualineconf')

vim.o.updatetime = 250
vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI' }, {
  group = vim.api.nvim_create_augroup('float_diagnostic_cursor', { clear = true }),
  callback = function ()
    vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})
  end
})

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = vim.g.tabNumber
vim.opt.shiftwidth = vim.g.tabNumber
vim.opt.cursorline = true
vim.opt.linebreak = false
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.scrolloff = 8
vim.opt.timeoutlen = 600
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.foldlevel = 99
vim.opt.foldenable = false
vim.opt.signcolumn = 'yes'
vim.opt.foldmethod = 'indent'
vim.opt.mouse = 'a'
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

local save = vim.api.nvim_create_augroup('SavePositionWhenLeaving', {clear = true})
vim.api.nvim_create_autocmd({'BufWritePost'}, {
	group = save,
	command = "silent! mkview"
})
vim.api.nvim_create_autocmd({"BufReadPost"}, {
	group = save,
	command = "silent! loadview"
})

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('yankcolor', {clear = true}),
	command = ("silent! lua vim.highlight.on_yank {higroup='IncSearch', timeout=70}")
})

vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
      local save_cursor = vim.fn.getpos(".")
      vim.cmd [[%s/\s\+$//e]]
      vim.fn.setpos(".", save_cursor)
    end,
})

vim.api.nvim_create_user_command('Deleteview',function() vim.cmd("!rm ~/.local/state/nvim/view/*") end,{})
vim.api.nvim_create_user_command('Ctags',function() vim.cmd("!ctags -R .") end, {})

vim.api.nvim_create_user_command('ClangFormart', function()
	vim.cmd('silent! !echo "UseTab: Always" > .clang-format')
	vim.cmd('silent! !echo "IndentWidth: "'..vim.g.tabNumber.. '>> .clang-format')
	vim.cmd('silent! !echo "TabWidth: "'..vim.g.tabNumber.. '>> .clang-format')
	vim.cmd('silent! !echo "ColumnLimit: 1000000" >> .clang-format')
	vim.cmd('silent! !echo "AllowShortFunctionsOnASingleLine: Empty" >> .clang-format')
	vim.cmd('silent! LspRestart')
end ,{})

if vim.loader then
	vim.loader.enable()
end
