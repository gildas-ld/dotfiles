vim.api.nvim_create_autocmd("BufWritePre", {
	buffer = 0,
	callback = function()
		vim.lsp.buf.format()
	end,
})

vim.keymap.set("n", "<leader>zb", ":!zig build<CR>", { buffer = true, silent = true })
vim.keymap.set("n", "<leader>zr", ":!zig run %<CR>", { buffer = true, silent = true })
vim.keymap.set("n", "<leader>zf", ":!zig fmt %<CR>", { buffer = true, silent = true })
