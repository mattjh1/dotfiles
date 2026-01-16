local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- Setup debugpy without calling refresh()
local function setup_debugpy()
	local mason_registry = require("mason-registry")

	-- Check if debugpy is installed without calling refresh
	local ok, debugpy = pcall(mason_registry.get_package, mason_registry, "debugpy")
	if ok and debugpy:is_installed() then
		local path = debugpy:get_install_path()
		dap_python.setup(path .. "/venv/bin/python")
		dap_python.test_runner = "pytest"
	else
		-- Fallback to system python
		print("debugpy not found in Mason registry. Please install it with :MasonInstall debugpy")
		dap_python.setup() -- This will use system python
		dap_python.test_runner = "pytest"
	end
end

-- Setup with a small delay to ensure Mason registry is ready
vim.defer_fn(setup_debugpy, 100)

dapui.setup()
