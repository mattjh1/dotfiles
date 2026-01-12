return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  opts = {
    options = {
      indicator = {
        style = 'icon',
        icon = '▎',
      },

      separator_style = 'thin',

      buffer_close_icon = '',
      close_icon = '',
      modified_icon = '●',

      left_trunc_marker = '',
      right_trunc_marker = '',

      max_name_length = 20,
      max_prefix_length = 15,
      tab_size = 22,

      show_buffer_close_icons = false,
      show_close_icon = false,
      always_show_bufferline = true,
    },
  },
}
