local err_prefix = "[lsp/servers/java.lua] "

local utils = require("utils")
local keymaps = require("lsp.keymaps")

-- -- --

local _jdtls, jdtls = pcall(require, "jdtls")
if not _jdtls then
	print(err_prefix .. "Failed to load jdtls")
	return
end

local _dap, dap = pcall(require, "dap")
if not _dap then
	print(err_prefix .. "Failed to load nvim-dap")
end

local _jdtls_dap, jdtls_dap = pcall(require, "jdtls.dap")
if not _jdtls_dap then
	print(err_prefix .. "Failed to load jdtls.dap")
	return
end

-- -- --

local _handlers, handlers = pcall(require, "lsp.handlers")


local os_name = utils.functions.get_os_name()

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.xml" }
local jdtls_bin = ""-- 'java' or '/path/to/java17_or_newer/bin/java'
local jdtls_path = "" -- Must point to eclipse.jdt.ls installation
local java_workspace = ""
local java_debug_path = os.getenv("HOME") .. "/.java/java-debug"

java_workspace = os.getenv("JAVA_WORKSPACE") and os.getenv("JAVA_WORKSPACE") or ""


-- ==================
--   SETUP SERVER
-- ==================

local _mason, _ = pcall(require, "mason")
if _mason then
	local mason_path = vim.fn.stdpath("data") .. "/mason/"
	jdtls_path = mason_path .. "packages/jdtls/"
	jdtls_bin = mason_path .. "bin/jdtls"-- 'java' or '/path/to/java17_or_newer/bin/java'
else
	-- Configure alternative jdtls location here
	print(err_prefix .. "Jdtls not configured")
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
	},
	init_options = {
		bundles = {
			vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 0)
		};
	}
}

-- ======================= 
--    SETUP DEBUGGER
-- =======================


dap.configurations.java = {
	{
		type = 'java';
		request = 'launch';
		name = "Launch";
		javaExec = jdtls_config.cmd;
	}
}

jdtls_dap.setup_dap(dap.configurations.java)

vim.api.nvim_create_autocmd('FileType', {
  group = java_cmds,
  pattern = {'java'},
  desc = 'Setup jdtls',
  callback = function() 
		jdtls.start_or_attach(jdtls_config)
	end,
})				

keymaps.setup_jdtls_keymaps()
-- -- FUNCTIONS -- --

--local get_project_name = function()
--	local cwd = vim.api.nvim_buf_get_name(0)
--	local dirname = ""
--	local dirname_temp = ""
--	if string.find(cwd, java_workspace, 1, true) then	
--		dirname = cwd
--		while dirname ~= java_workspace do
--			dirname_temp = dirname
--			dirname = vim.fn.fnamemodify(dirname, ":p:h:h")
--			dirname_temp = vim.fn.fnamemodify(dirname_temp, ":p:h")
--		end
--		return dirname_temp
--	end
--	return ""
--end


