local err_prefix = "[lsp/servers/cpp] "

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

