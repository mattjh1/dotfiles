return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended by the plugin
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'notes',
        path = '$HOME/notes-vault',
      },
    },

    notes_subdir = 'vault',

    daily_notes = {
      folder = 'vault/dailies',
      template = 'log-template.md',
    },

    new_notes_location = 'current_dir',

    wiki_link_func = function(opts)
      if opts.id == nil then
        return string.format('[[%s]]', opts.label)
      elseif opts.label ~= opts.id then
        return string.format('[[%s|%s]]', opts.id, opts.label)
      else
        return string.format('[[%s]]', opts.id)
      end
    end,

    note_id_func = function(title)
      local suffix = ''
      if title ~= nil then
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,

    templates = {
      subdir = 'vault/Templates',
      date_format = '%Y-%m-%d-%a',
      time_format = '%H:%M',
    },
    open = {
      func = function(uri)
        -- vim.fn.jobstart { 'open', url } -- macOS
        vim.ui.open(uri, { cmd = { 'xdg-open' } })
      end,
    },
  },
}
