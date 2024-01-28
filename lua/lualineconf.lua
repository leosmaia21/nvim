local maxSizeFile = 5
local function filename()
	local currentFile = vim.fn.split(vim.api.nvim_buf_get_name(0), "/")
	local currentFile = currentFile[#currentFile]
	if vim.api.nvim_buf_get_option(0, 'buftype') ~= '' then return currentFile end
	local lenSize = vim.fn.strlen(currentFile)
	if (lenSize > maxSizeFile) then maxSizeFile = lenSize end
	if maxSizeFile % 2 == 0 then maxSizeFile = maxSizeFile + 1 end
	local padding = math.floor((maxSizeFile - lenSize) / 2)
	if lenSize % 2 == 0 then currentFile = currentFile .. " " end
	local padding = string.rep(" ", padding)
	if lenSize > 12 then maxSizeFile = 12 end
	return padding .. currentFile .. padding
end

local function unsavedFiles()
	if vim.api.nvim_buf_get_option(0, 'buftype') ~= ''  then return '' end
	local unsavedbuf = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_option(buf, 'buftype') == ''  then
			if vim.api.nvim_buf_get_option(buf,'modified') then
				unsavedbuf = unsavedbuf + 1
				-- return 'Unsaved files' -- any message or icon
			end
		end
	end
	return unsavedbuf ~= 0 and "[+"..unsavedbuf.."] " or ''
end

local function harpoonFiles()
	if vim.api.nvim_buf_get_option(0, 'buftype') ~= '' then return '' end
	local currentFile = vim.fn.split(vim.api.nvim_buf_get_name(0), "/")
	local currentFile = currentFile[#currentFile]
	local ret = ''
	for key, value in ipairs(require("harpoon").get_mark_config()['marks']) do
		local file = vim.fn.split(value['filename'], "/")
		file = file[#file]
		file = file == currentFile and file .. "*" or file .. " "
		ret = ret .. "  " .. key .. " " .. file
	end
	return ret
end

local oilextension = { sections = {
	lualine_a = {
		function()
			local ok, oil = pcall(require, 'oil')
			if ok then
				local currentDir = vim.fn.split(vim.fn.getcwd(), "/")
				local currentDir = #currentDir
				local oilDir = vim.fn.split(oil.get_current_dir(), "/")
				local ret = ""
				for key, value in pairs(oilDir) do
					if key >= currentDir then
						ret = ret == "" and value or ret.."/"..value
					end
				end
				return ret
			end
			return ''
		end,
		function()
			return vim.api.nvim_buf_get_option(0,'modified') and 'Unsaved Actions' or ''
		end
	},
},
	filetypes = {'oil'}
}

require("lualine").setup{
	options = {
		icons_enabled = true,
		component_separators = "|",
		section_separators = "",
		refresh = {statusline = 300},
		theme = vim.g.colors_name == 'rose-pine' and 'nord' or 'auto'
	},
	extensions = {oilextension},
	sections = {
		lualine_a = {filename, unsavedFiles},
		lualine_b = {{ 'diagnostics', sources = { 'nvim_lsp' }},harpoonFiles},
		lualine_c = {},
		lualine_x = {},
		-- lualine_y = {},
		-- lualine_z = {},
	}
}
