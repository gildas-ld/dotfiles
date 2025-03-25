local aug = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd
local g = aug("UserAutoCmds", { clear = true })

-- Update diagnostics on save
au("BufWritePost", {
	group = g,
	callback = function()
		vim.diagnostic.setloclist({ open = false })
	end,
})

-- Quick close for help, qf, etc.
au("FileType", {
	group = g,
	pattern = { "help", "qf", "lspinfo" },
	callback = function(ev)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
	end,
})
