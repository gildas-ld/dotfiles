require("lazy").setup({
	-- Bars & breadcrumbs
	{ "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
	{ "SmiteshP/nvim-navic", lazy = true },

	-- Outline
	{ "stevearc/aerial.nvim", opts = {} },

	-- Git
	{ "lewis6991/gitsigns.nvim", opts = {} },
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	},

	-- Movement & search
	{ "folke/flash.nvim", opts = {} },
	{ "nvim-pack/nvim-spectre", dependencies = { "nvim-lua/plenary.nvim" } },

	{
		"neovim/nvim-lspconfig",
	},
	{
		"ziglang/zig.vim",
		ft = "zig",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"zig",
			},
		},
	},
	{ "folke/neodev.nvim", ft = { "lua" }, opts = {} },

	-- Pairs / indent / todos / ui-select
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
	{ "stevearc/dressing.nvim", opts = {} },

	-- UI
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { options = { theme = "auto", globalstatus = true } },
	},
	{ "folke/which-key.nvim", opts = {} },
	{
		"rcarriga/nvim-notify",
		opts = {
			stages = "static",
			timeout = 5000,
			render = "default",
			fps = 30,
			top_down = true,
			minimum_width = 40,
			max_width = 80,
			max_height = 20,
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		opts = {
			lsp = {
				progress = { enabled = false },
				signature = { enabled = true },
				hover = { enabled = true },
			},
			presets = { lsp_doc_border = true },
			views = {
				cmdline_popup = { win_options = { winblend = 0 } },
				popupmenu = { win_options = { winblend = 0 } },
				mini = { win_options = { winblend = 0 } },
			},
		},
	},

	-- Core
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"c",
				"cpp",
				"cmake",
				"make",
				"bash",
				"lua",
				"python",
				"java",
				"kotlin",
				"rust",
				"json",
				"yaml",
				"toml",
				"markdown",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
	},

	-- Files & navigation
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = false,
			view_options = { show_hidden = true },
			keymaps = { ["q"] = "actions.close" },
		},
		config = function(_, opts)
			require("oil").setup(opts)
			vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>", { silent = true, desc = "Oil: open" })
			vim.keymap.set("n", "-", "<cmd>Oil<CR>", { silent = true, desc = "Oil: parent dir" })
		end,
	},
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},

	-- Sidebar explorer (permanent)
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				sources = { "filesystem", "buffers", "git_status" },
				close_if_last_window = true,
				filesystem = {
					follow_current_file = { enabled = true },
					filtered_items = { hide_dotfiles = false, hide_gitignored = true },
					hijack_netrw_behavior = "disabled", -- Avoid conflict with Oil
				},
				window = {
					width = 35,
					mappings = {
						["o"] = "open",
						["<space>"] = "toggle_node",
						["s"] = "open_split",
						["v"] = "open_vsplit",
						["t"] = "open_tabnew",
						["q"] = "close_window",
					},
				},
				default_component_configs = {
					git_status = {
						symbols = { added = "A", modified = "M", deleted = "D", renamed = "R", untracked = "U" },
					},
				},
			})
			-- Keymaps: toggle neo-tree and focus filesystem
			vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { silent = true, desc = "Neo-tree: toggle" })
			vim.keymap.set(
				"n",
				"<leader>fe",
				"<cmd>Neotree focus filesystem left<CR>",
				{ silent = true, desc = "Neo-tree: focus" }
			)
		end,
	},
	-- Text
	{ "numToStr/Comment.nvim", opts = {} },
	{ "kylechui/nvim-surround", opts = {} },

	-- Snippets & completion
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		build = "make install_jsregexp",
		opts = {},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				}),
			})
		end,
	},

	-- LSP & tools
	{ "williamboman/mason.nvim", config = true },
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "lua_ls" },
				automatic_installation = true,
			})
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = { "clangd", "--header-insertion=never", "--background-index", "--clang-tidy" },
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})
			lspconfig.zls.setup({
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "<leader>zf", function()
						vim.lsp.buf.format()
					end, { buffer = bufnr })
				end,
			})

			vim.diagnostic.config({
				virtual_text = { spacing = 2, prefix = "●" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
	{
		"ludovicchabant/vim-gutentags",
		init = function()
			vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache/tags")

			vim.g.gutentags_modules = { "ctags" }

			vim.g.gutentags_ctags_extra_args = {
				"--fields=+nSkz",
				"--extras=+q",
				"--kinds-Asm=+dlm",
				"--kinds-C++=+cdefgmnpstuvx",
				"--kinds-C=+defgmpstuvx",
				"--kinds-Java=+cifmpa",
				"--kinds-Kotlin=+cfinmp",
				"--kinds-Lua=+cfm",
				"--kinds-Python=+cfm",
				"--kinds-SQL=+fptv",
				"--kinds-Sh=+f",
				"--kinds-XML=+t",
				"--kinds-Zsh=+f",
			}
		end,
	},
	-- Format & lint
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
				cmake = { "cmake_format" },
				lua = { "stylua" },
				sh = { "shfmt" },
				python = { "black" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				c = { "clangtidy", "cppcheck" },
				cpp = { "clangtidy", "cppcheck" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
	},
	-- DAP
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		opts = {
			ensure_installed = { "codelldb", "cpptools", "gdb" },
			handlers = {},
		},
	},

	-- CMake & tasks
	{
		"Civitasv/cmake-tools.nvim",
		opts = {
			cmake_build_directory = "build",
			cmake_kits_path = nil,
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
		},
	},
	{ "stevearc/overseer.nvim", opts = {} },

	-- Project nav
	{ "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

	defaults = { version = "*" },
}, {
	ui = { border = "rounded" },
})
