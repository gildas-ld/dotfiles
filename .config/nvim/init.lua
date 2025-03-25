-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- Clone lazy.nvim if not found
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

-- Prepend lazy.nvim to runtimepath
vim.opt.rtp:prepend(lazypath)

-- Load basic settings
require("options")
require("keymaps")

-- Load plugins using lazy.nvim
require("plugins")

-- Load plugin configuration
require("plugin_config")

-- Load autocommands
require("autocmds")
