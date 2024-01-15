local _neodev, neodev = pcall(require, "neodev")

if not _neodev then
	print("[plugins/configs/neodev.lua] Failed to load neodev")
	return
end

neodev.setup({
	library = {
		plugins = {
			"nvim-dap-ui"
		},
		types = true,
	},
})
