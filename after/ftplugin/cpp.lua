
vim.bo.commentstring = "// %s"
local opts = {buffer = 0,  noremap = true, silent = true }
-- vim.keymap.set('i', 'ss', 'std::', opts)

-- vim.keymap.set('n', 'ss', function() 
-- 	local current_line = vim.api.nvim_get_current_line()
-- 	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	if current_line[col] == ' ' then
-- 		vim.api.nvim_buf_set_text({0}, {row}, {col}, {row}, {col + 5}, ['std::'])
-- 	end
-- end, opts)
