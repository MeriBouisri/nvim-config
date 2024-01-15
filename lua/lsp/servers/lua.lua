local err_prefix = "[lsp/servers/lua.lua]"

-- -- --

local _neodev, neodev = pcall(require, "neodev")
if not _neodev then
	print(err_prefix .. "Failed to load neodev")
	return
end

local _lspcfg, lspcfg = pcall(require, 'lspconfig')
if not _lspcfg then
	print(err_prefix .. "Failed to load lspconfig")
	return
end

local _lspcmp, lspcmp = pcall(require, 'cmp_nvim_lsp')
if not _lspcmp then
	print(err_prefix .. "Failed to load cmp_nvim_lsp")
	return
end

-- -- --

neodev.setup()

lspcfg["lua_ls"].setup({
	server = {
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
				},

				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},

	capabilities = lspcmp.default_capabilities(),
})
