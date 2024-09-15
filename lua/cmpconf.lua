local cmp = require('cmp')
-- local luasnip = require('luasnip')

cmp.setup({
	--  window = {
	--        completion = {
	--            border = "rounded",
	--            winhighlight = "Normal:CmpNormal",
	-- 	},
	-- 	documentation = {
	-- 		winhighlight = "Normal:Pmenu",
	-- 	}
	-- },
	sources = {
		{name = 'nvim_lsp'},
		{name = 'buffer',
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end
			}
		},
		{name = 'path' },
		-- {name = 'luasnip' },
	},
	-- snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = true}),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-c>'] = cmp.mapping.close(),
		-- ['<Tab>'] = cmp.mapping(function(fallback)
		-- 	local status_ok, luasnip = pcall(require, "luasnip")
		-- 	if status_ok and luasnip.expand_or_locally_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	else
		-- 		fallback()
		-- 	end
		-- 	end, { "i", "s"}),
		-- ['<S-Tab>'] = cmp.mapping(function(fallback)
		-- 	local status_ok, luasnip = pcall(require, "luasnip")
		-- 	if status_ok and luasnip.expand_or_locally_jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- 	end, { "i", "s"})
	},
	formatting = {
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
			return item
		end,
	}
})
