
--Ora muito bom dia, se quiserem usar o coc estão a vontade, mas aviso já que aquilo é feito em javascript...

local lsp = require('lsp-zero').preset()
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

--Remove semantic highlighting from lsp, already have treesitter
lsp.set_server_config({
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

require'lspconfig'.pylsp.setup{
	on_attach=on_attach_vim,
	settings = { 
		pylsp = { 
			plugins = {
				pycodestyle =  { enabled = false },
				pylint =  { enabled = false },
			} 
		} 
	}
}

require("lspconfig").clangd.setup {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}

lsp.setup()

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
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
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- You need to setup `cmp` after lsp-zero
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local luasnip = require('luasnip')
luasnip.config.set_config({
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})

cmp.setup({
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = true}),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		-- ['<C-c>'] = cmp.mapping.close(),
		["<Tab>"] = cmp.mapping(function(fallback)
			local status_ok, luasnip = pcall(require, "luasnip")
			-- if cmp.visible() then
			-- 	cmp.select_next_item()
			if status_ok and luasnip.expand_or_locally_jumpable() then
			-- if status_ok and luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
			end, { "i", "s"}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			local status_ok, luasnip = pcall(require, "luasnip")
			-- if cmp.visible() then
			-- 	cmp.select_prev_item()
			if status_ok and luasnip.expand_or_locally_jumpable(-1) then
			-- if status_ok and luasnip.expand_or_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
			end, { "i", "s"})
	}
})

require("mason-lspconfig").setup {
	ensure_installed = { "clangd", "pylsp"},
}
