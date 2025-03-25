-- General editor options
local opt = vim.opt
opt.encoding = "utf-8"
opt.fileformats = { "unix", "dos", "mac" }
opt.compatible = false
opt.guifont = "Consolas:h18"
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.mouse = "a"

-- Indentation and tabs
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smarttab = true
opt.shiftround = true
opt.breakindent = true
opt.copyindent = true

-- Folding
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Clipboard
if vim.fn.has("unnamedplus") == 1 then
	opt.clipboard = "unnamed,unnamedplus"
end

-- Statusline
opt.laststatus = 2
opt.statusline = " ☠ %F%m%r%h%w (%{&ff}/%Y) ⚐ %y%m%r%* ❑ %n%=✎ %(%l:%c%) ⇨ %P"

-- Wildmenu
opt.wildmenu = true
opt.wildmode = { "list:longest", "list:full" }
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

-- Undo, backup, swap
local data_dir = vim.fn.stdpath("data")
opt.undofile = true
opt.undodir = data_dir .. "/undodir"
opt.backup = true
opt.backupdir = data_dir .. "/backup"
opt.directory = data_dir .. "/swap"

-- Wrap, spell, formatting
opt.wrap = false
opt.textwidth = 78
opt.wrapmargin = 0
opt.spell = true
opt.spelllang = { "fr", "en" }
opt.fileencodings = { "ucs-bom", "utf-8", "latin1" }

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Sessions
opt.autochdir = true
opt.sessionoptions:remove("buffers")
opt.sessionoptions:remove("curdir")
opt.sessionoptions:append({ "sesdir", "globals" })
