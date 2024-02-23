-- Manipulate media controls
-- For convienience bind media control keys to hyper instead of fn
--
function mediaControl(key)
	hs.eventtap.event.newSystemKeyEvent(key, true):post()
	hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

local hyper = { "shift", "ctrl", "alt", "cmd" }

-- Media controls
hs.hotkey.bind(hyper, "F7", function()
	mediaControl("REWIND")
end)
hs.hotkey.bind(hyper, "x", function()
	mediaControl("PLAY")
end)
hs.hotkey.bind(hyper, "F8", function()
	mediaControl("PLAY")
end)
hs.hotkey.bind(hyper, "F9", function()
	mediaControl("FAST")
end)
hs.hotkey.bind(hyper, "F10", function()
	mediaControl("MUTE")
end)
hs.hotkey.bind(hyper, "F11", function()
	mediaControl("SOUND_DOWN")
end)
hs.hotkey.bind(hyper, "F12", function()
	mediaControl("SOUND_UP")
end)
