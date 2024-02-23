-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.
--
-- --------------------------------------------------------------------------------
return {
	---  { 'a' } RESERVED FOR WINDOW MANAGEMENT
	{ "w", "Google Chrome" },        -- "W" for "Web Browser"
	{ "c", "Hub | Microsoft Teams" }, -- "C" for "Chat" use for Teams web app
	-- { "c", "Microsoft Teams (classic)" }, -- "C" for "Chat" use for Teams web app
	{ "e", "Visual Studio Code" },   -- "E" for "Editor"
	{ "f", "Finder" },               -- "F" for "Finder"
	{ "v", "Obsidian" },             -- "F" for "Finder"
	{ "o", "Microsoft Outlook" },    -- "O" for "OutlookOutlook
	{ "s", "Spotify" },              -- "S" for "Spotify"
	{ "t", "Alacritty" },            -- "T" for "Terminal"
	{ "m", "Messages" },             -- "M" for "Messages"
	{ "d", "Discord" },              -- "D" for "Discord"
	{ "b", "DBeaver" },              -- "B" for "Beaver"
	{ "n", "Neo4j Desktop" },
}
