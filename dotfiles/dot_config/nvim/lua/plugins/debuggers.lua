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

local path = require("mason-registry").get_package("debugpy"):get_install_path()
print(path)

dap_python.setup(path .. "/venv/bin/python")
dap_python.test_runner = "pytest"
dap_python.default_port = 38000

dapui.setup()
