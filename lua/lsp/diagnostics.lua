local utils = require("utils")

for type, sign in pairs(utils.icons.diagnostics) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = sign, numhl = hl, texthl = hl })
end

local config = {
	signs = true,
	underline = false,
	virtual_text = false,
	update_in_insert = false,
}

vim.diagnostic.config(config)
