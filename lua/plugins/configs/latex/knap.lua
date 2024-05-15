-- set shorter name for keymap function
local kmap = vim.keymap.set

latex_engine = {
	latexmk = "latexmk",
	pdflatex = "pdflatex",
	lualatex = "lualatex"
}


ltex_workspace = os.getenv("HOME") .. "/workspaces/latex-workspace"
latexmkrc = os.getenv("HOME") .. "/.latexmkrc"
pdf_viewers = {
	zathura = "zathura",
	x11_zathura = "GDK_BACKEND=x11 zathura"
}
-- F5 processes the document once, and refreshes the view
kmap({ 'n', },'txu', function() require("knap").process_once() end)

-- F6 closes the viewer application, and allows settings to be reset
kmap({ 'n', },'txq', function() require("knap").close_viewer() end)

-- F7 toggles the auto-processing on and off
kmap({ 'n', },'txp', function() require("knap").toggle_autopreviewing() end)

-- F8 invokes a SyncTeX forward search, or similar, where appropriate
kmap({ 'n', },'txj', function() require("knap").forward_jump() end)




local gknapsettings = {
    texoutputext = "pdf",
    textopdf = latex_engine.pdflatex .. " -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
    textopdfviewerlaunch = pdf_viewers.x11_zathura .. " %outputfile%",
    --textopdfviewerrefresh = "none",
		--textopdfforwardjump = "okular --unique %outputfile%'#src:%line% '%srcfile%"
}
vim.g.knap_settings = gknapsettings

