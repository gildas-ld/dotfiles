vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File
map("n", "<leader>w", "<cmd>w<cr>", opts)
map("n", "<leader>q", "<cmd>q<cr>", opts)

-- Navigation
map("n", "<leader>e", "<cmd>Neotree toggle left<cr>", opts)
map("n", "<leader>E", "<cmd>Neotree reveal left<cr>", opts)
map("n", "<C-n>", "<cmd>Neotree focus left<cr>", opts)
map("n", "-", "<cmd>Oil<cr>", opts)
map("n", "<leader>o", "<cmd>Oil<cr>", opts)
map("n", "<leader>O", function()
	local ok, oil = pcall(require, "oil")
	if ok then
		oil.open_float()
	end
end, opts)

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- LSP
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

-- Paste mode
map("n", "<F2>", "<cmd>set invpaste paste?<cr>", opts)
map("i", "<F2>", "<C-o><cmd>set invpaste paste?<cr>", opts)

-- Escape shortcuts
map("i", "jj", "<Esc>", opts)
map("i", ";;", "<Esc>", opts)

-- Move lines
map("n", "<C-UP>", "<cmd>silent! move-2<cr>==", opts)
map("n", "<C-DOWN>", "<cmd>silent! move+<cr>==", opts)
map("x", "<C-UP>", "<cmd>silent! '<,'>move-2<cr>gv=gv", opts)
map("x", "<C-DOWN>", "<cmd>silent! '<,'>move'>+<cr>gv=gv", opts)

-- Insert shortcuts
map("i", "$1", "()<Esc>i", opts)
map("i", "$2", "[]<Esc>i", opts)
map("i", "$3", "{}<Esc>i", opts)
map("i", "$q", "''<Esc>i", opts)
map("i", "$e", '""<Esc>i', opts)

-- Abbreviations
map("i", "xdate", function()
	return vim.fn.strftime("%d/%m/%y %H:%M:%S")
end, { expr = true, noremap = true, silent = true })

-- DAP
map("n", "<F5>", function()
	require("dap").continue()
end, opts)
map("n", "<F10>", function()
	require("dap").step_over()
end, opts)
map("n", "<F11>", function()
	require("dap").step_into()
end, opts)
map("n", "<F12>", function()
	require("dap").step_out()
end, opts)
map("n", "<leader>b", function()
	require("dap").toggle_breakpoint()
end, opts)
map("n", "<leader>B", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)
map("n", "<leader>du", function()
	require("dapui").toggle()
end, opts)

-- Terminal / Serial
map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", opts)
map("n", "<leader>ts", "<cmd>SerialMonitorToggle<cr>", opts)

-- Git
map("n", "<leader>gs", "<cmd>Gitsigns toggle_signs<cr>", opts)
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", opts)

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>dd", vim.diagnostic.open_float, opts)
map("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Which-key / Cheatsheet
map("n", "<leader>?", "<cmd>WhichKey<cr>", opts)
map("n", "<leader>c?", "<cmd>Cheatsheet<cr>", opts)

-- Telescope: find + history
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opts)
map("n", "<leader>fc", "<cmd>Telescope command_history<cr>", opts)
map("n", "<leader>f/", "<cmd>Telescope search_history<cr>", opts)
map("n", "<leader>fr", "<cmd>Telescope frecency<cr>", opts) -- requires sqlite
map("n", "<leader>fy", "<cmd>Telescope neoclip<cr>", opts) -- yank history
map("n", "<leader>fu", "<cmd>Telescope undo<cr>", opts) -- undo tree (telescope)

-- Undotree (UI ultra-légère)
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", opts)

-- Noice: messages/cmdline history
map("n", "<leader>nn", "<cmd>Noice<cr>", opts)
map("n", "<leader>nh", "<cmd>Noice history<cr>", opts)

-- Which-key: group labels (v2 API)
pcall(function()
	local wk = require("which-key")
	wk.add({
		{ "<leader>f", group = "Find/History" },
		{ "<leader>n", group = "Noice" },
		{ "<leader>c", group = "Cheatsheet" },
	})
end)
