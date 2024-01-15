local M = {}

local err_prefix = "[lsp/keymaps.lua] "

local map_opts = { noremap = true, silent = true }

M.leader = {
	diagnostics = "<leader><C-d>",
	debugger = "<leader>d" 
} 

M.setup_diagnostics_keymaps = function()
	vim.keymap.set("n", M.leader.diagnostics, vim.diagnostic.open_float, map_opts)
	vim.keymap.set("n", M.leader.diagnostics .. "k", vim.diagnostic.goto_prev, map_opts)
	vim.keymap.set("n", M.leader.diagnostics .. "j", vim.diagnostic.goto_next, map_opts)
end


M.setup_debugger_keymaps = function()
	local _dap, dap = pcall(require, 'dap')
	if not _dap then
		print(err_prefix .. "Failed to load dap")
		return
	end

	vim.keymap.set("n", M.leader.debugger .. "0", function() dap.continue() end)
	vim.keymap.set("n", M.leader.debugger .. "1", function() dap.step_over() end)
	vim.keymap.set("n", M.leader.debugger .. "2", function() dap.step_into() end)
	vim.keymap.set("n", M.leader.debugger .. "3", function() dap.step_out() end)

	vim.keymap.set("n", M.leader.debugger .. "r", function() dap.restart() end)
	vim.keymap.set("n", M.leader.debugger .. "q", function() dap.terminate() end)

	-- Breakpoints
	
	vim.keymap.set("n", M.leader.debugger .. "B", function() dap.toggle_breakpoint() end)
	vim.keymap.set("n", M.leader.debugger .. "b", function() dap.set_breakpoint() end)
	vim.keymap.set("n", M.leader.debugger .. "bm", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
	vim.keymap.set("n", M.leader.debugger .. "br", function() dap.clear_breakpoints() end)
	vim.keymap.set("n", M.leader.debugger .. "bc", function() dap.run_to_cursor() end)

end

--- Setup all keymap configurations
M.setup_keymaps = function()
	M.setup_diagnostics_keymaps()
	M.setup_debugger_keymaps()
end

return M
