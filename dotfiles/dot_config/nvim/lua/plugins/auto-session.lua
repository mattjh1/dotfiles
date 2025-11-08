local auto_session = require("auto-session")

auto_session.setup({
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  auto_restore_enabled = true,
  auto_save_enabled = true,
  pre_restore_cmds = { "silent! TSBufDisable highlight" },
  post_restore_cmds = { "silent! TSEnable highlight" },
})
