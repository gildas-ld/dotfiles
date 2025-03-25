vim.api.nvim_create_augroup("vimrc", { clear = true })

-- Folding
vim.api.nvim_create_autocmd("BufReadPre", {
	group = "vimrc",
	command = "setlocal foldmethod=indent",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "vimrc",
	callback = function()
		if vim.opt_local.foldmethod:get() == "indent" then
			vim.opt_local.foldmethod = "manual"
		end
	end,
})

-- Paste mode off after leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	group = "vimrc",
	command = "set nopaste",
})
