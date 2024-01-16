local err_prefix = "[lsp/servers/python.lua] "

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

local _dap, dap = pcall(require, "dap")
if not _dap then
	print(err_prefix .. "Failed to load dap")
	return
end


-- VARIABLES --

local python_exec = "python3"
local debugpy_path = os.getenv('HOME') .. '.virtualenvs/tools'
local venv_names = { "venv", ".venv" }


-- FUNCTIONS --

--- Find path of python executable. First looks in virtual environment of the current project, if present.
--- If none, returns the python executable in /usr/bin/ .
---@return string path of python executable
local find_python_path = function()
	local cwd = vim.fn.getcwd()

	for _, venv in ipairs(venv_names) do
		local venv_path = cwd .. '/' .. venv .. '/bin/' .. python_exec

		if vim.fn.executable(venv_path) == 1 then
			return venv_path
		end

	end

	return '/usr/bin/' .. python_exec
end


-----------------
-- DEBUGGER SETUP
-----------------

dap.adapters.python = {
	type = 'executable';
	command = debugpy_path .. '/bin/' .. python_exec;
	args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
	{
		type = 'python';
		request = 'launch';
		name = 'Launch file';
		program = '${file}';
		console = "externalTerminal";
		pythonPath = find_python_path();
	},
}

---------------
-- SERVER SETUP
---------------

lspcfg.pyright.setup({
	server = {
		settings = {
			pyright = {
				pythonPath = find_python_path()
			}
		}
	},

	capabilities = lspcmp.default_capabilities()
})

