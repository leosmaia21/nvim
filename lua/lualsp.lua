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
		-- vim.keymap.set('n', 'gr',  require('telescope.builtin').lsp_references, opts)
		vim.keymap.set('n', '<A-f>', function()
		vim.lsp.buf.format {async = true } end, opts)
		vim.opt.tagfunc=""
	end
})
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
lsp_capabilities.textDocument.completion.completionItem.snippetSupport = false
local default_setup = function(server)
        require('lspconfig')[server].setup({
		capabilities = lsp_capabilities,
	})
end

local lspconfig = require('lspconfig')
-- require('mason').setup({})
-- require('mason-lspconfig').setup({
-- 	-- ensure_installed = {'verible'},
-- 	handlers = { default_setup},
-- })

-- lspconfig.pylsp.setup{
-- 		settings = { pylsp = { plugins = { pycodestyle =  { enabled = false }, pylint =  { enabled = false }, } } }
-- }

-- lspconfig.veridian.setup{capabilities = lsp_capabilities, root_dir = lspconfig.util.root_pattern("*.v")}
-- lspconfig.verible.setup{capabilities = lsp_capabilities , root_dir = lspconfig.util.root_pattern("*.v")}
-- local j = tostring("-j=" .. tonumber(vim.fn.system('nproc')))
-- print(j)
lspconfig.clangd.setup{cmd = 
	{"/depot/glibc/glibc-2.20/lib/ld-2.20.so", 
	"/u/lmaia/binaries/clangd_17.0.3/bin/clangd",
	"--background-index=false",
	 },
	cmd_env = {C_INCLUDE_PATH = "/u/lmaia/binaries/clangd_17.0.3/lib/clang/17/include",
	CPLUS_INCLUDE_PATH = "/u/lmaia/binaries/clangd_17.0.3/lib/clang/17/include"
	}
	, capabilities = lsp_capabilities}

	-- "--pch-storage=memory",
	-- "--background-index",
