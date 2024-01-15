local _treesitter, treesitter = pcall(require, "nvim-treesitter.configs")

if not _treesitter then
	print("[nvim-config-treesitter] Failed to load treesitter")
	return
end

treesitter.setup {
	ensure_installed = {
		"lua",
	},

	sync_install = false,

	highlight = {
		enable = true,
		disable = {},
	},

	indent = { enable = true, },

}

