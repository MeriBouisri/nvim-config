local scripts_path = ".config/nvim/scripts"

local M = {}

local fs_script = "filesystem.sh"
M.concat = function(separator, table)
	local concat_string = ""
	for _, str in ipairs(table) do
		concat_string = concat_string .. str .. separator
	end
	return concat_string
end

M._run_shell_script = function(script_filename, opts)
	local script = scripts_path .. "/" .. script_filename
	local sep = " "
	local concat_opts = M.concat(sep, opts)
	local exit_code = os.execute("sh " .. script .. sep .. concat_opts)
	exit_code = exit_code / 256

	return exit_code == 0
end
M.get_os_name = function()
	if vim.fn.has("win32") == 1 then
		return "win"
	end

	if vim.fn.has("unix") == 1 then
		return "linux"
	end

	if vim.fn.has("mac") == 1 then
		return "mac"
	end
end

M.file_exists = function(file)
	local f = io.open(file, "r")
	if f then f:close() end
	return f ~= nil
	--return M._run_shell_script(fs_script, { "file_exists", filename })
end

M.dir_exists = function(dirname)
	return M._run_shell_script(fs_script, { "dir_exists", dirname })
end

M.create_dir = function(dirname)
	return M._run_shell_script(fs_script, { "create_dir", dirname})
end

M.create_file = function(filename)
	return M._run_shell_script(fs_script, { "create_file", filename})
end

M.toggle_relnum = function()
	if not vim.wo.relativenumber and not vim.wo.number then
		return
	end
	vim.wo.relativenumber = not vim.wo.relativenumber
end

M.lines_from = function(file)
	
	local lines = {}

	if not M.file_exists(file) then 
		print("File " .. file .. " does not exist")
		return lines
	end

	for line in io.lines(file) do
		lines[#lines + 1] = line
	end

	return lines
end

return M
