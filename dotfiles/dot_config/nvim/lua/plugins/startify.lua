-- Too lazy to port vimL, so this will do for now
vim.cmd [[
let g:startify_bookmarks = [
  \ { 'z': '~/.zshrc' },
  \ { 'v': '~/.config/nvim/init.vim' },
  \ { 's': '~/.local/share/nvim/site/autoload/start_screen.vim' },
  \ { 't': '~/.tmux.conf' },
  \ { 'a': '~/.config/alacritty/alacritty.yml' },
  \ ]

let g:startify_custom_header = [
  \ '         ______________    ',
  \ '        /             /|   ',
  \ '       /             / |   ',
  \ '      /____________ /  |   ',
  \ '     | ___________ |   |   ',
  \ '     ||           ||   |   ',
  \ '     ||   VIM     ||   |   ',
  \ '     ||  RULES!   ||   |   ',
  \ '     ||___________||   |   ',
  \ '     |   _______   |  /    ',
  \ '    /|  (_______)  | /     ',
  \ '   ( |_____________|/      ',
  \ '    \                      ',
  \ '.=======================.  ',
  \ '| ::::::::::::::::  ::: |  ',
  \ '| ::::::::::::::[]  ::: |  ',
  \ '|   -----------     ::: |  ',
  \ '`-----------------------'   ,
  \]

let g:startify_fortune_use_unicode = 0

let g:startify_lists = [
  \ { 'header': ['   Bookmarks'],       'type': 'bookmarks' },
  \ { 'header': ['   Recent'],            'type': 'files' },
  \ { 'header': ['   Current Directory '. getcwd()], 'type': 'dir' },
  \ { 'header': ['   Sessions'],       'type': 'sessions' },
  \ ]

nmap <leader> mm :Startify<cr>

let g:startify_session_dir = '~/.vim_sessions'
]]
