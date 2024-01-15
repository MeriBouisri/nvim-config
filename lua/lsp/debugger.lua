local err_prefix = "[lsp/debugger.lua] "

-- -- -- 

local _dap, dap = pcall(require, "dap")
if not _dap then
	print(err_prefix .. "Failed to load nvim-dap")
	return
end

local _dapui, dapui = pcall(require, "dapui")
if not _dapui then
	print(err_prefix .. "Failed to load nvim-dap-ui")
	return
end

local _daptext, daptext = pcall(require, "nvim-dap-virtual-text")
if not _daptext then
	print(err_prefix .. "Failed to load nvim-dap-virtual-text")
end

-- -- --

vim.fn.sign_define('DapBreakpoint', {text='•', texthl='red', linehl='', numhl=''})

dap.defaults.fallback.force_external_terminal = true
dap.defaults.fallback.external_terminal = {
	command = "tmux",
	args = { "split-pane", "-c", vim.fn.getcwd(), "-l", 10},
}

dapui.setup({
	layouts = {
		{
			position = "right",
			size = 40,
			elements = {
				{	id = "scopes", size = 0.8 },
				{ id = "stacks", size = 0.1 },
				{ id = "breakpoints", size = 0.1 },
			},
		},
	},

	mappings = {
		edit = "r",
		expand = { "<CR>", "<2-LeftMouse>", "L" },
		remove = "d",
		repl = "r",
		toggle = "t",
	},
})

local attach_dapui = function()
	dap.listeners.before.attach.dapui_config = function() dapui.open() end
	dap.listeners.before.launch.dapui_config = function() dapui.open() end
	dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
	dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
end

attach_dapui()

