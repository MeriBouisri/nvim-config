
local _keymaps, keymaps = pcall(require, "lsp.keymaps")

if _keymaps then
	keymaps.setup_diagnostics_keymaps()
	keymaps.setup_debugger_keymaps()
end

-- Diagnostics

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		require("lsp.diagnostics")
		require("lsp.debugger")
	end,
})

-- Mason

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
	},
})



-- Load servers

require('lsp.servers')

