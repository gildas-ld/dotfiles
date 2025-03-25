-- Load plugins with lazy.nvim
require("lazy").setup({
	-- CoC plugin
	{ "neoclide/coc.nvim", branch = "release" },

	{
		"ibhagwan/fzf-lua",
		-- enable `sk` support instead of the default `fzf`
		opts = { "skim" },
	},

	-- Python support
	"Vimjas/vim-python-pep8-indent",
	"davidhalter/jedi-vim",

	-- Tmux
	"tmux-plugins/vim-tmux",

	-- LSP
	{ "neovim/nvim-lspconfig" },
	{ "numToStr/Comment.nvim", config = true },
	{ "stevearc/conform.nvim" },
	{ "kylechui/nvim-surround", config = true },
	{ "mcchrish/nnn.vim" },

	-- Completion & snippets
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },

	-- TypeScript tools
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},
})

-- LSP configuration
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enable Python language server
lspconfig.pylsp.setup({ capabilities = capabilities })

-- TypeScript/JavaScript with typescript-tools.nvim
require("typescript-tools").setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Enable other language servers
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.jdtls.setup({ capabilities = capabilities }) -- Requires jdtls
lspconfig.kotlin_language_server.setup({ capabilities = capabilities }) -- Requires kotlin-language-server
lspconfig.bashls.setup({ capabilities = capabilities })

-- Configure autocompletion
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			-- Expand snippet with LuaSnip
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})
