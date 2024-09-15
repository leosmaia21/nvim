local marks = {}
local bufnr = vim.api.nvim_get_current_buf()
local index = 1

local r, c = unpack(vim.api.nvim_buf_get_mark(0, "'"))
m = vim.fn.getmarklist()
print(vim.inspect(m))

-- print(marks[1])
