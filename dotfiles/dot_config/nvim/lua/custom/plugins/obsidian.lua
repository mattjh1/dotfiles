return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended by the plugin
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'notes',
        path = '$HOME/Documents/Notes/vault',
      },
    },

    notes_subdir = 'vault',

    daily_notes = {
      folder = 'vault/dailies',
      template = 'log-template.md',
    },

    new_notes_location = 'current_dir',

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    wiki_link_func = function(opts)
      if opts.id == nil then
        return string.format('[[%s]]', opts.label)
      elseif opts.label ~= opts.id then
        return string.format('[[%s|%s]]', opts.id, opts.label)
      else
        return string.format('[[%s]]', opts.id)
      end
    end,

    open_app_foreground = true,

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

    follow_url_func = function(url)
      vim.fn.jobstart { 'open', url } -- macOS
      -- vim.fn.jobstart({ "xdg-open", url }) -- Linux
    end,
  },
}
