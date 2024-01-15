local M = {}

local signature_cfg = {
	bind = true,
	doc_lines = 2,
	floating_window = false,
	hint_enable = false,
	hint_scheme = "String",
	use_lspdsaga = false,
	hi_parameter = "Search",
	max_height = 12,
	max_width = 120,
	handler_opts = {
		border = "single",
	},
}

--local function set_document_highlighting(client)
--	local dfp = client.server_capabilities.documentFormattingProvider
--	if dfp == true or (type(dfp) == "table" and next(dfp) ~= nil) then
--		require("illuminate").on_attach(client)
--	end
--end

local function set_signature_helper(client, bifnr)
	local shp = client.server_capabilities.signatureHelpProvider
	if shp == true or (type(shp) == "table" and next(shp) ~= nil) then
		require("lsp_signature").on_attach(signature_cfg, bufnr)
	end
end

local function set_hover_border(client)
	local hp = client.server_capabilities.hoverProvider
	if hp == true or (type(hp) == "table" and next(hp) ~= nil) then
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {})
	end
end

M.on_attach = function(client, bufnr)
	--set_signature_helper(client, bufnr)
	--set_hover_border(client)
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M
