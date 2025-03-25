-- General editor options
local opt = vim.opt

opt.autochdir = true
opt.autoindent = true
opt.backup = true
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.compatible = false
opt.copyindent = true
opt.cursorline = true
opt.encoding = "utf-8"
opt.expandtab = true
opt.fileencodings = { "ucs-bom", "utf-8", "latin1" }
opt.fileformats = { "unix", "dos", "mac" }
opt.foldenable = false
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.guifont = "Consolas:h18"
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.shiftround = true
opt.shiftwidth = 4
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.spell = true
opt.spelllang = { "fr", "en" }
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.textwidth = 78
opt.timeoutlen = 400
opt.undofile = true
opt.updatetime = 200
opt.wildmenu = true
opt.wildmode = { "list:longest", "list:full" }
opt.wrap = false
opt.wrapmargin = 0

local data_dir = vim.fn.stdpath("data")
opt.undodir = data_dir .. "/undodir"
opt.backupdir = data_dir .. "/backup"
opt.directory = data_dir .. "/swap"

opt.wildignore:append({
	"*/tmp/*",
	"*.so",
	"*.swp",
	"*.zip",
	"*.pyc",
	"*.db",
	"*.sqlite",
	"*node_modules/",
})

vim.lsp.config("jdtls", {
	cmd = { "/usr/bin/jdtls" },
})

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction")
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "K", function()
	vim.cmd.RustLsp({ "hover", "actions" })
end, { silent = true, buffer = bufnr })
