local maxSizeFile = 5

local function filename()
	local currentFile = vim.fn.split(vim.api.nvim_buf_get_name(0), "/")
	currentFile = currentFile[#currentFile]
	if vim.api.nvim_buf_get_option(0, 'buftype') ~= '' then return currentFile end
	local lenSize = string.len(currentFile)
	if (lenSize > maxSizeFile) then maxSizeFile = lenSize end
	if maxSizeFile % 2 == 0 then maxSizeFile = maxSizeFile + 1 end
	local padding = math.floor((maxSizeFile - lenSize) / 2)
	if lenSize % 2 == 0 then currentFile = currentFile .. " " end
	padding = string.rep(" ", padding)
	if lenSize > 15 then maxSizeFile = 15 end
	return padding .. currentFile .. padding
end

local function unsavedFiles()
if vim.api.nvim_buf_get_option(0, 'buftype') ~= ''  then return '' end
for i, buf in ipairs(vim.api.nvim_list_bufs()) do
	if vim.api.nvim_buf_get_option(buf, 'buftype') == ''  then
		if vim.api.nvim_buf_get_option(buf,'modified') then
			return 'Unsaved files' -- any message or icon
		end
	end
end
return ''
end

local harpoon = require("harpoon")
local function harpoonFiles() 
	if vim.api.nvim_buf_get_option(0, 'buftype') ~= '' then return '' end
	local tabela = harpoon.get_mark_config()['marks']
	local currentFile = vim.fn.split(vim.api.nvim_buf_get_name(0), "/")
	currentFile = currentFile[#currentFile]
	local ret = {}
	for key, value in pairs(tabela) do
		local file = vim.fn.split(value['filename'], "/")
		file = file[#file]
		file = file == currentFile and file .. "*" or file .. " "
		table.insert(ret, "  " .. key .. " " .. file)
	end
	return table.concat(ret)
end

require("lualine").setup{
	options = {
		icons_enabled = true,
		component_separators = "|",
		section_separators = "",
		refresh = {statusline = 300},
	},
	sections = { 
		lualine_a = {filename, unsavedFiles, 'branch'},
		lualine_b = {{ 'diagnostics', sources = { 'nvim_lsp' }},harpoonFiles},
		lualine_c = {},
		lualine_x = {},
		-- lualine_y = {},
		-- lualine_z = {},
	}
}
