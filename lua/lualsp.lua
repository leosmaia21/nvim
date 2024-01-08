local lspconfig = require('lspconfig')
local lsp_zero = require('lsp-zero')

require('mason').setup()
require("mason-lspconfig").setup {
	ensure_installed = { "clangd", "pylsp"},
	handlers = {lsp_zero.default_setup}
}

lsp_zero.set_server_config({
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- lspconfig.clangd.setup {cmd = { "clangd", "--offset-encoding=utf-16", }}

lspconfig.pylsp.setup{
	settings = { pylsp = { plugins = { pycodestyle =  { enabled = false }, pylint =  { enabled = false }, } } }
}

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr',  require('telescope.builtin').lsp_references, opts)
		vim.keymap.set('n', '<A-f>', function()
			vim.lsp.buf.format {async = true }
		end, opts)
	end,
})

local cmp = require('cmp')
local luasnip = require('luasnip')

-- require('luasnip.loaders.from_vscode').lazy_load()

luasnip.config.set_config({
	history = true,
	region_check_events = "InsertEnter",
	delete_check_events = "TextChanged,InsertLeave",
})

cmp.setup({
	sources = {
		{name = 'nvim_lsp'},
		-- {name = 'luasnip' },
		{name = 'buffer' },
		{name = 'path' },
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = true}),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-c>'] = cmp.mapping.close(),
		['<Tab>'] = cmp.mapping(function(fallback)
			local status_ok, luasnip = pcall(require, "luasnip")
			if status_ok and luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
			end, { "i", "s"}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			local status_ok, luasnip = pcall(require, "luasnip")
			if status_ok and luasnip.expand_or_locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
			end, { "i", "s"})
	},
	formatting = lsp_zero.cmp_format(),
})
