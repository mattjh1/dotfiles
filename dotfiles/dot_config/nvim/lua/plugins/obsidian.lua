local options = {
	workspaces = {
		{
			name = "notes",
			path = "$HOME/Documents/Notes/vault",
		},
		{
			name = "sos-alarm",
			path = "$HOME/sos-alarm-notes",
		},
	},
	notes_subdir = "vault",
	daily_notes = {
		folder = "vault/dailies",
		template = "log-template.md",
	},
	-- Where to put new notes created from completion. Valid options are
	--  * "current_dir" - put new notes in same directory as the current buffer.
	--  * "notes_subdir" - put new notes in the default notes subdirectory.
	new_notes_location = "current_dir",
	completion = {
		-- Set to false to disable completion.
		nvim_cmp = true,

		-- Trigger completion at 2 chars.
		min_chars = 2,
	},
	wiki_link_func = function(opts)
		if opts.id == nil then
			return string.format("[[%s]]", opts.label)
		elseif opts.label ~= opts.id then
			return string.format("[[%s|%s]]", opts.id, opts.label)
		else
			return string.format("[[%s]]", opts.id)
		end
	end,
	open_app_foreground = true,
	-- Optional, customize how names/IDs for new notes are created.
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- In this case a note with the title 'My new note' will be given an ID that looks
		-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return tostring(os.time()) .. "-" .. suffix
	end,
	templates = {
		subdir = "vault/Templates",
		date_format = "%Y-%m-%d-%a",
		time_format = "%H:%M",
	},
	follow_url_func = function(url)
		-- Open the URL in the default web browser.
		vim.fn.jobstart({ "open", url }) -- Mac OS
		-- vim.fn.jobstart({"xdg-open", url})  -- linux
	end,
}

require("obsidian").setup(options)
