local maxSizeFile = 5
local function filename()
	local currentFile = vim.api.nvim_buf_get_name(0):match("[^/]+$")
	if vim.api.nvim_buf_get_option(0, 'buftype') ~= '' then return currentFile end
	local lenSize = string.len(currentFile)
	if (lenSize > maxSizeFile) then maxSizeFile = lenSize end
	local padding = string.rep(" ", (maxSizeFile - lenSize) / 2)
	local ret = padding .. currentFile .. padding
	if lenSize > 13 then maxSizeFile = 13 end
	return  string.len(ret) % 2 == 0 and ret.." " or ret
end

local function unsavedFiles()
	local vimbuf = vim.api.nvim_buf_get_option
	if vimbuf(0, 'buftype') ~= ''  then return '' end
	local unsavedbuf = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vimbuf(buf, 'buftype') == '' and vimbuf(buf,'modified')  then
			unsavedbuf = unsavedbuf + 1
		end
	end
	return unsavedbuf ~= 0 and "[+"..unsavedbuf.."] " or ''
end

local function harpoonFiles()
	if vim.api.nvim_buf_get_option(0, 'buftype') ~= '' then return '' end
	local currentFile = vim.api.nvim_buf_get_name(0):match("[^/]+$")
	local ret = ''
	for key, value in ipairs(require("harpoon").get_mark_config()['marks']) do
		local file = value['filename']:match("[^/]+$")
		file = file == currentFile and file .. "*" or file .. " "
		ret = ret .. "  " .. key .. " " .. file
	end
	return ret
end

local oilextension = {
	sections = {
		lualine_a = {
			function()
				local ok, oil = pcall(require, 'oil')
				if ok == true then
					local currentDir = vim.fn.getcwd():match("(.*)/")
					local oilDir = oil.get_current_dir():gsub(currentDir, "")
					return oilDir ~= "" and oilDir or oil.get_current_dir()
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
		refresh = {statusline = 250},
		theme = vim.g.colors_name == 'rose-pine' and 'nord' or 'auto'
	},
	extensions = {oilextension},
	sections = {
		lualine_a = {filename, unsavedFiles},
		lualine_b = {harpoonFiles},
		lualine_c = {},
		lualine_x = {},
		-- lualine_y = {},
		-- lualine_z = {},
	}
}
