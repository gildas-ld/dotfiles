-- Python/Jedi
vim.g["jedi#auto_vim_configuration"] = 1
vim.g["jedi#environment_path"] = "/usr/bin/python3"
vim.g["jedi#popup_select_first"] = 0
vim.g["jedi#use_splits_not_buffers"] = "left"
vim.g["jedi#completions_enabled"] = 1
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.coc_disable_startup_warning = 1

-- Ale
vim.b.ale_fixers = { javascript = { "prettier", "eslint" } }
vim.g.ale_fixers = {
	["*"] = { "remove_trailing_lines", "trim_whitespace" },
	javascript = { "eslint" },
}
vim.g.ale_fix_on_save = 1

-- NNN config
vim.g.nnn_set_default_mappings = 0
vim.keymap.set("n", "<leader>nn", ":NnnPicker<CR>", { silent = true })
vim.keymap.set("n", "<leader>n", ":NnnPicker %:p:h<CR>", { silent = true })
vim.g.nnn_layout = { window = { width = 0.9, height = 0.6, highlight = "Comment" } }
