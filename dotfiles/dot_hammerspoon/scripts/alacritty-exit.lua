hs.hotkey.bind({ "ctrl", "alt" }, "Q", function()
	local alacritty = hs.application.get("Alacritty")
	if alacritty then
		local win = alacritty:focusedWindow()
		if win then
			win:close()
		end
	end
end)
