local M = {}

-- Print table contents (for debugging)
function M.dump(o)
	print(vim.inspect(o))
end

-- Execute shell command and return output
function M.exec(cmd)
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
	return result
end

return M
