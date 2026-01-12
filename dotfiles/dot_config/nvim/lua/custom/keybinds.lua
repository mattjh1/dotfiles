local map = vim.keymap.set

------------------------------------------------------------
-- Editing
------------------------------------------------------------

map('n', 'Y', 'y$', { desc = 'Yank to end of line' })

map({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yank' })

-- Better wrapped-line movement
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  silent = true,
  desc = 'Down (visual line)',
})
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  silent = true,
  desc = 'Up (visual line)',
})

-- Keep selection when indenting
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })

------------------------------------------------------------
-- Move lines
------------------------------------------------------------

map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

------------------------------------------------------------
-- Window navigation
------------------------------------------------------------

map('n', '<C-h>', '<C-w>h', { desc = 'Focus left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Focus lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Focus upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Focus right window' })

-- Resize windows
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

------------------------------------------------------------
-- Scrolling & search
------------------------------------------------------------

map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
map('n', 'n', 'nzzzv', { desc = 'Next search result' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

------------------------------------------------------------
-- Files & buffers
------------------------------------------------------------

map('n', '<leader>w', '<cmd>wa<CR>', { desc = '[W]rite all buffers' })

map('n', '<leader>bd', '<cmd>BufDel<CR>', { desc = '[B]uffer delete' })
map('n', '<leader>bD', '<cmd>BufDelOthers<CR>', { desc = 'Delete other buffers' })

map('n', '<leader>qq', '<cmd>qa<CR>', { desc = '[Q]uit all' })

