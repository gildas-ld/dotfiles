vim.api.nvim_create_autocmd("BufWritePre", {
	buffer = 0,
	callback = function()
		vim.lsp.buf.format()
	end,
})

local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction")
end, { buffer = bufnr, silent = true })

vim.keymap.set("n", "K", function()
	vim.cmd.RustLsp({ "hover", "actions" })
end, { buffer = bufnr, silent = true })

vim.keymap.set("n", "<leader>rr", function()
	vim.cmd.RustLsp("run")
end, { buffer = bufnr, silent = true })
vim.keymap.set("n", "<leader>rt", function()
	vim.cmd.RustLsp("testables")
end, { buffer = bufnr, silent = true })
vim.keymap.set("n", "<leader>rd", function()
	vim.cmd.RustLsp("debuggables")
end, { buffer = bufnr, silent = true })

vim.keymap.set("n", "<leader>re", function()
	vim.cmd.RustLsp("explainError")
end, { buffer = bufnr, silent = true })
vim.keymap.set("n", "<leader>rm", function()
	vim.cmd.RustLsp("expandMacro")
end, { buffer = bufnr, silent = true })
vim.keymap.set("n", "<leader>ro", function()
	vim.cmd.RustLsp("openDocs")
end, { buffer = bufnr, silent = true })
