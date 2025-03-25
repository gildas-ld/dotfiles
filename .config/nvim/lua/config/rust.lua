vim.g.rustaceanvim = function()
	local cfg = require("rustaceanvim.config")

	local extension_path = (vim.env.HOME or "") .. "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb"
	local os_name = vim.uv.os_uname().sysname
	if os_name:find("Windows") then
		codelldb_path = extension_path .. "adapter\\codelldb.exe"
		liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
	else
		liblldb_path = liblldb_path .. (os_name == "Linux" and ".so" or ".dylib")
	end

	local dap_cfg = {}
	if vim.uv.fs_stat(codelldb_path) and vim.uv.fs_stat(liblldb_path) then
		dap_cfg.adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
	end

	return {
		tools = {
			test_executor = "background",
			code_actions = { ui_select_fallback = true },
			hover_actions = { auto_focus = true },
		},
		server = {
			on_attach = function(_, bufnr)
				local ih = vim.lsp.inlay_hint
				if type(ih) == "table" and ih.enable then
					pcall(ih.enable, true, { bufnr = bufnr })
				end
			end,
			default_settings = {
				["rust-analyzer"] = {
					cargo = { allFeatures = true },
					checkOnSave = { command = "clippy" },
					procMacro = { enable = true },
					diagnostics = { disabled = { "unresolved-proc-macro" } },
				},
			},
		},
		dap = dap_cfg,
	}
end
