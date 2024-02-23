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
	completion = {
		-- Set to false to disable completion.
		nvim_cmp = true,

		-- Trigger completion at 2 chars.
		min_chars = 2,

		-- Where to put new notes created from completion. Valid options are
		--  * "current_dir" - put new notes in same directory as the current buffer.
		--  * "notes_subdir" - put new notes in the default notes subdirectory.
		new_notes_location = "current_dir",

		-- Control how wiki links are completed with these (mutually exclusive) options:
		--
		-- 1. Whether to add the note ID during completion.
		-- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
		-- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
		prepend_note_id = true,
		-- 2. Whether to add the note path during completion.
		-- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
		-- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
		prepend_note_path = false,
		-- 3. Whether to only use paths during completion.
		-- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
		-- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
		use_path_only = false,
	},
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
