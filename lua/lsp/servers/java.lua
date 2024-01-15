local utils = require("utils")

local _jdtls, jdtls = pcall(require, "jdtls")
local _handlers, handlers = pcall(require, "lsp.handlers")

-- TODO: setup dap
local _dap, dap = pcall(require, "dap")


if not _jdtls then
	print("[ERROR] Failed to load jdtls")
	return
end

if not _dap then
	print("[ERROR] Failed to load nvim-dap")
end



local jdtls_bin = ""-- 'java' or '/path/to/java17_or_newer/bin/java'
local jdtls_path = "" -- Must point to eclipse.jdt.ls installation
local has_mason, _ = pcall(require, "mason")
if has_mason then
	local mason_path = vim.fn.stdpath("data") .. "/mason/"
	jdtls_path = mason_path .. "packages/jdtls/"
	jdtls_bin = mason_path .. "bin/jdtls"-- 'java' or '/path/to/java17_or_newer/bin/java'
else
	-- Configure alternative jdtls location here
	print("[ERROR] Jdtls not configured")
	return
end

-- Find equinox launcher without having to rewrite the version again
local equinox_launcher_path = ""
local equinox_file_list = vim.fn.split(vim.fn.glob(jdtls_path .. "plugins/*.jar"), "\n")
for _, file in pairs(equinox_file_list) do
	if string.match(file, "launcher_") then
		equinox_launcher_path = file
		break
	end
end

local os_name = utils.functions.get_os_name()
local java_workspace = ""
java_workspace = os.getenv("JAVA_WORKSPACE") and os.getenv("JAVA_WORKSPACE") or ""

local get_project_name = function()
	local cwd = vim.api.nvim_buf_get_name(0)
	local dirname = ""
	local dirname_temp = ""
	if string.find(cwd, java_workspace, 1, true) then	
		dirname = cwd
		while dirname ~= java_workspace do
			dirname_temp = dirname
			dirname = vim.fn.fnamemodify(dirname, ":p:h:h")
			dirname_temp = vim.fn.fnamemodify(dirname_temp, ":p:h")
		end
		return dirname_temp
	end
	return ""
end

--local configuration_path = jdtls_path .. "config_" .. os_name
--local workspace_name = get_project_name()
--local workspace_path = get_project_name()
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.xml" }

dap.configurations.java = {

}

local function on_attach(client, bufnr)
	handlers.on_attach(client, bufnr)

end

local jdtls_config = {
	cmd = { jdtls_bin },
	root_dir = jdtls.setup.find_root(root_markers),
	capabilities = handlers.capabilities,
	on_attach = on_attach,
	settings = {
		java = {
			signatureHelp = { enabled = true },
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
		},
	}
}
local jdtls_setup = function()
	local jdtls = require('jdtls')
	jdtls.start_or_attach(jdtls_config)
end


vim.api.nvim_create_autocmd('FileType', {
  group = java_cmds,
  pattern = {'java'},
  desc = 'Setup jdtls',
  callback = jdtls_setup,
})															

--return {
--
--	cmd = generate_jdtls_cmd(jdtls_bin, equinox_launcher_path, configuration_path, workspace_path),
--	root_dir = require('jdtls.setup').find_root(root_markers), 
--		-- require('jdtls.setup').find_root(root_markers),
--	settings = {
--		java = {
--		},
--	},
--}
