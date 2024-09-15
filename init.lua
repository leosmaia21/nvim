-- local std = "/tmp"
-- local old_stdpath = vim.fn.stdpath
-- if vim.fn.isdirectory(std) ~=0 then
-- 	vim.fn.stdpath = function(value)
-- 		if value == 'data' then
-- 			return std .. "/neovim/data" 
-- 		end
-- 		if value == 'cache' then
-- 			return std .. "/neovim/cache" 
-- 		end
-- 		if value == 'state' then
-- 			return std .. "/neovim/state" 
-- 		end
-- 		return old_stdpath(value)
-- 	end
-- end


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- vim.env.C_INCLUDE_PATH="/u/lmaia/binaries/clangd_17.0.3/lib/clang/17/include"
vim.env.PATH = "/depot/gcc-13.2.0/bin:" .. vim.env.PATH
vim.g.filetype_v="verilog"

vim.g.tabNumber = 4
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
require("lazy").setup({
	-- {'chriskempson/base16-vim', priority = 1000},
	-- {"kshenoy/vim-signature"},
	{'rose-pine/neovim', name = 'rose-pine', priority = 1000},

	-- {'nvim-telescope/telescope.nvim', lazy = true, config = function()
	-- 	require('telescope').setup{defaults = {
	-- 		layout_config = {prompt_position = "top"},
	-- 		sorting_strategy = "ascending"
	-- 	},
	-- }
	--  require('telescope').load_extension('fzf')
	-- end,
	--  dependencies = {{'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}, }
	-- },

	{
		"ibhagwan/fzf-lua",
		lazy = true,
		config = function()
			require("fzf-lua").setup({
				winopts = {preview = {hidden = 'hidden'}}
			})
		end
	},

	{'nvim-lua/plenary.nvim', lazy = true},

	{'alexghergh/nvim-tmux-navigation', 
	keys = {{'<C-n>', vim.cmd.NvimTmuxNavigateNext}},
	config = function()
		require'nvim-tmux-navigation'.setup{} end },

	-- {'mg979/vim-visual-multi', event = "VeryLazy"},

	-- {'tpope/vim-fugitive', event = "VeryLazy"},
	-- {'tpope/vim-rhubarb', event = "VeryLazy"},
	{'kylechui/nvim-surround', 
	event = "VeryLazy",
	version = "*", config = function()
		require("nvim-surround").setup() end },
	-- {"tpope/vim-surround"},

	{'mbbill/undotree', keys = {{'<leader>u', vim.cmd.UndotreeToggle}}},

	-- {'nvim-neotest/nvim-nio', lazy = true},
	--
	-- {'mfussenegger/nvim-dap', lazy = true},
	-- {'theHamsta/nvim-dap-virtual-text', lazy = true},
	-- {"rcarriga/nvim-dap-ui", lazy = true},
	-- {'mfussenegger/nvim-dap-python', lazy = true},

	{'nvim-lualine/lualine.nvim'},

	-- {'chentoast/marks.nvim'}, 

	{'lukas-reineke/indent-blankline.nvim',
	lazy = true,
	main = 'ibl', config = function()
		require"ibl".setup{
			indent = {char = "│", highlight = "LineNr"},
			scope = {enabled = false},
		} end
	},

	{'nvim-treesitter/nvim-treesitter',
	lazy = true,
	build = ":TSUpdate", config = function()
		require 'nvim-treesitter.install'.compilers = {'gcc'}
		require'nvim-treesitter.configs'.setup {
			auto_install = true,
			-- ignore_install = {"verilog"},
			highlight = {
				enable = true,
				disable = {
					-- "tcl", 
					-- "verilog",
					-- "cpp",
				},
				additional_vim_regex_highlighting = {"verilog", "tcl", "makefile"}
			},
		}
	end
	},

	-- {'stevearc/aerial.nvim', event = 'VeryLazy', config = function()
	--	require('aerial').setup({ close_on_select = true, autojump = true })
	--	require('telescope').load_extension('aerial')
	-- end },

	-- {'nvim-tree/nvim-web-devicons', lazy = true},
	
	{'nvim-tree/nvim-tree.lua',
		keys = {
			{ "<leader>e", vim.cmd.NvimTreeFindFileToggle},
		},
	config = function()
		require("nvim-tree").setup{
			git = {enable = false},
			renderer = {icons = {show =  {folder = false, git = false, file = false, folder_arrow= false}}},
			diagnostics = {enable=false}
		}
	end
},

	{'stevearc/oil.nvim', 
	keys = {{"<leader>o", vim.cmd.Oil}},
	config = function()
		require("oil").setup({
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			-- skip_confirm_for_simple_edits = true,
			keymaps = {
				["<C-v>"]	= "actions.select_vsplit",
				["<C-x>"]	= "actions.select_split",
				["<BS>"] 	= "actions.parent",
				["H"]		= "actions.toggle_hidden",
			},
		})
	end},

	{'windwp/nvim-autopairs', event = "InsertEnter", config = function()
		require("nvim-autopairs").setup()
	end},

	-- {'dense-analysis/ale'},

	{'neovim/nvim-lspconfig',
		ft = {"cpp", "c"},
		dependencies = {
		-- {'williamboman/mason.nvim'},
		-- {'williamboman/mason-lspconfig.nvim'},
		{'hrsh7th/cmp-nvim-lsp'},
		},
	config = function()
		require('lualsp')
	end
	},


	{'hrsh7th/nvim-cmp',
		event = "InsertEnter",
		dependencies = {
		-- {'L3MON4D3/LuaSnip'},
		{'hrsh7th/cmp-path'},
		{'hrsh7th/cmp-buffer'}
		},
	config = function()
		require('cmpconf')
	end
	},

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
	    -- disable_background = true,
		-- disable_float_background = false,
		

		styles = {
			bold = false,
			italic = false,
			transparency = true,
		},
		highlight_groups = {
			TelescopeBorder = {  bg = "overlay" },
			TelescopeNormal = { bg = "overlay" },
			-- TelescopeSelection = { fg = "text", bg = "highlight_med" },
			-- TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
			-- TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
			-- TelescopePromptTitle = { fg = "base", bg = "pine" },
			-- TelescopePreviewTitle = { fg = "base", bg = "iris" },
			TelescopePromptNormal = { fg = "text", bg = "overlay" },
			-- TelescopePromptBorder = { fg = "surface", bg = "surface" },
		},
	})


vim.cmd.colorscheme('rose-pine')
-- vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#26233a" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#26234F" })
-- vim.api.nvim_set_hl(0, "CmpSel", { bg = "#FFFFFF" })


for _, element in ipairs({ 'FloatBorder', 'NormalFloat' }) do 
	vim.api.nvim_set_hl(0, element, { bg = '#26233a' })
end
-- vim.cmd.colorscheme('modus')


require('keymap')
-- require('debugger')
require('lualineconf')

-- vim.o.updatetime = 250
-- vim.api.nvim_create_autocmd({'CursorHold'}, {
--   group = vim.api.nvim_create_augroup('float_diagnostic_cursor', { clear = true }),
--   callback = function ()
-- 	vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})
--   end
-- })

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
vim.opt.ignorecase = false
vim.opt.undofile = true
vim.opt.spell = false
-- if vim.fn.isdirectory("/slowfs/us01dwt2p395/lmaia/.vimundo") then
-- 	vim.opt.undodir = "/slowfs/us01dwt2p395/lmaia/.vimundo"
-- end
vim.opt.foldlevel = 99
vim.opt.foldenable = false
vim.opt.signcolumn = 'yes'
vim.opt.foldmethod = 'indent'
vim.opt.mouse = 'a'
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

local spell = false
vim.keymap.set('n', '<leader>s', function() 
	if spell then 
		spell = false
	else 
		spell = true
	end  
	vim.opt.spell = spell 
end)

local save = vim.api.nvim_create_augroup('SavePositionWhenLeaving', {clear = true})
vim.api.nvim_create_autocmd({'BufReadPost'}, {
	group = save,
	pattern = '*',
	command = 'silent! normal! g`"zv',
})

-- vim.api.nvim_create_autocmd({'BufWritePost'}, {
-- 	group = save,
-- 	command = "silent! mkview"
-- })
-- vim.api.nvim_create_autocmd({"BufReadPost"}, {
-- 	group = save,
-- 	command = "silent! loadview"
-- })

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('yankcolor', {clear = true}),
	command = ("silent! lua vim.highlight.on_yank {higroup='IncSearch', timeout=70}")
})

vim.api.nvim_create_user_command('Deleteview',function() vim.cmd("!rm ~/.local/state/nvim/view/*") end,{})
vim.api.nvim_create_user_command('Ctags',function() vim.cmd("!ctags -R .") end, {})
vim.api.nvim_create_user_command('Debugger',function() require("debugger") end, {})

format = {
	"IndentWidth: 4",
	"TabWidth: 4",
	"ColumnLimit: 1000000",
	"AllowShortFunctionsOnASingleLine: None",
	"PackConstructorInitializers: Never",
	"BreakConstructorInitializers: AfterColon",
	"AllowShortLambdasOnASingleLine: None",
}

vim.api.nvim_create_user_command('ClangFormart', function()
	vim.cmd('silent! !echo -n "" > .clang-format')
	for k,v in pairs(format) do
		vim.cmd('silent! !echo '.. tostring(v) .. ' >> .clang-format')
	end
end ,{})

vim.cmd(":hi DiffAdd ctermfg=0 ctermbg=10 guifg=NvimLightGrey1 guibg=NvimDarkGreen")
vim.cmd(":hi DiffChange guifg=NvimLightGrey1 guibg=NvimDarkGrey4")
vim.cmd(":hi DiffDelete cterm=bold ctermfg=9 gui=bold guifg=NvimLightRed")
vim.cmd(":hi DiffText ctermfg=0 ctermbg=14 guifg=NvimLightGrey1 guibg=NvimDarkCyan")


vim.api.nvim_set_hl(0, '@variable.member', { fg="#e0def4"})

if vim.loader then
	vim.loader.enable()
end

