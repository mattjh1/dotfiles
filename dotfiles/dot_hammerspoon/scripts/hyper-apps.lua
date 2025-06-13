-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.
--
-- --------------------------------------------------------------------------------
return {
  ---  { 'a' } RESERVED FOR WINDOW MANAGEMENT
  --
  { "w", "Microsoft Edge" }, -- "W" for "Web Browser"
  -- { "w", "Google Chrome" }, -- "W" for "Web Browser"
  -- { "w", "Safari" }, -- "W" for "Web Browser"
  -- { "w", "Firefox" }, -- "W" for "Web Browser"
  -- { "w", "Brave Browser" }, -- "W" for "Web Browser"
  --
  -- { "c", "Hub | Microsoft Teams" }, -- "C" for "Chat" use for Teams PWA app
  { "c", "Microsoft Teams" },  -- "C" for "Chat" use for Teams app
  { "f", "Finder" },           -- "F" for "Finder"
  { "v", "Obsidian" },         -- "F" for "Finder"
  { "o", "Microsoft Outlook" }, -- "O" for "Outlook"
  { "s", "Spotify" },          -- "S" for "Spotify"
  { "t", "Alacritty" },        -- "T" for "Terminal"
  { "m", "Messages" },         -- "M" for "Messages"
  { "d", "Discord" },          -- "D" for "Discord"
  { "p", "1Password" },        -- "P" for "Password"
  { "g", "Citrix Viewer" },    -- "G" for "Gitrix Viewer" :)
}
