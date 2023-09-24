
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local lspconfig = require('lspconfig')

require('mason').setup({})
require("mason-lspconfig").setup {
	ensure_installed = { "clangd", "pylsp"},
	handlers = {
		function(server_name)
			lspconfig[server_name].setup {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			}
		end
	}
}

lspconfig.pylsp.setup{
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		client.server_capabilities.semanticTokensProvider = nil
	end,
	settings = { pylsp = { plugins = { pycodestyle =  { enabled = false }, pylint =  { enabled = false }, } } }
}

lspconfig.clangd.setup {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		client.server_capabilities.semanticTokensProvider = nil
	end,
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
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
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr',  require('telescope.builtin').lsp_references, opts)
		vim.keymap.set('n', '<A-f>', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

local cmp = require('cmp')
local luasnip = require('luasnip')

luasnip.config.set_config({
	history = true,
	updateevents = 'TextChanged,TextChangedI',
})

cmp.setup({
	sources = {
		{name = 'nvim_lsp'},
		{name = 'path' },
		{name = 'buffer' },
		{name = 'luasnip' },
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
		['<C-l>'] = cmp.mapping(function(fallback)
			local status_ok, luasnip = pcall(require, "luasnip")
			if status_ok and luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
			end, { "i", "s"}),
		['<C-m>'] = cmp.mapping(function(fallback)
			local status_ok, luasnip = pcall(require, "luasnip")
			if status_ok and luasnip.expand_or_locally_jumpable(-1) then
				luasnip.jump(-1)
			end
			end, { "i", "s"})
	},
	formatting = {
		fields = {'abbr', 'menu', 'kind'},
		format = function(entry, item)
			local short_name = { nvim_lsp = 'LSP', nvim_lua = 'nvim' }
			local menu_name = short_name[entry.source.name] or entry.source.name
			item.menu = string.format('[%s]', menu_name)
			return item
		end,
	}
})

