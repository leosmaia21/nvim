function format(opts)
  opts = opts or {}
  local maxwidth = opts.max_width or false
  return {
    fields = {'abbr', 'menu', 'kind'},
    format = function(entry, item)
      local n = entry.source.name
      if n == 'nvim_lsp' then
        item.menu = '[LSP]'
      elseif n == 'nvim_lua'  then
        item.menu = '[nvim]'
      else
        item.menu = string.format('[%s]', n)
      end

      if maxwidth and #item.abbr > maxwidth then
        local last = item.kind == 'Snippet' and '~' or ''
        item.abbr = string.format(
          '%s %s',
          string.sub(item.abbr, 1, maxwidth),
          last
        )
      end
      return item
    end,
  }
end


-- vim.keymap.set('n', 'gd', '<C-]>', opts)
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
		vim.lsp.get_client_by_id(event.data.client_id).server_capabilities.semanticTokensProvider = nil
    local opts = {buffer = event.buf}
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr',  require('telescope.builtin').lsp_references, opts)
		vim.keymap.set('n', '<A-f>', function()
			vim.lsp.buf.format {async = true } end, opts)
  end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
  require('lspconfig')[server].setup({
    capabilities = lsp_capabilities,
  })
end

local lspconfig = require('lspconfig')
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = { default_setup, },
})
local cmp = require('cmp')
local luasnip = require('luasnip')

-- lspconfig.svls.setup({
--     capabilities = lsp_capabilities,
-- })

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
	formatting = format()
})
