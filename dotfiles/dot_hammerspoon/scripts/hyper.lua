local status, hyperModeAppMappings = pcall(require, "scripts.hyper-apps")

if not status then
	hyperModeAppMappings = require("scripts.hyper-apps")
end

for _, mapping in ipairs(hyperModeAppMappings) do
	local key = mapping[1]
	local app = mapping[2]
	hs.hotkey.bind({ "shift", "ctrl", "alt", "cmd" }, key, function()
		if type(app) == "string" then
			hs.application.open(app)
		elseif type(app) == "function" then
			app()
		else
			hs.logger.new("hyper"):e("Invalid mapping for Hyper +", key)
		end
	end)
end
