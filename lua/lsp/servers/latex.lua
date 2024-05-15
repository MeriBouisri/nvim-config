local utils = require("utils.functions")
local err_prefix = "[lsp/servers/latex.lua]"

-- -- -- 

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

local tex_workspace = os.getenv("HOME") .. "/workspaces/latex-workspace"


latex_engine = {
	latexmk = "latexmk",
	pdflatex = "pdflatex",
	lualatex = "lualatex",
}

lspcfg["texlab"].setup({
	capabilities = lspcmp.default_capabilities(),
	settings = {
		texlab = {
			diagnosticsDelay = 50,
			build = {
				executable = latex_engine.pdflatex,
				args = { '-synctex=1', '-interaction=batchmode', '%f' },
			--	--args = { '-output-directory', '%:h', '-synctex=1', '-halt-on-error', '-interaction=batchmode', '%f' },
			--	--args = { '-synctex=1', '-halt-on-error', '-interaction=batchmode', '%f' },
				onSave = true
			},
			chktex = {
				onEdit = true
			}
		},

	}
})

