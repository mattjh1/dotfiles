vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opts = { silent = true, noremap = true }

vim.keymap.set("", "Y", "y$", opts)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)

-- Move line up/down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)

-- Change pane vertically
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Change pane horizontally
vim.keymap.set("n", "J", "<C-w>j", opts)
vim.keymap.set("n", "K", "<C-w>k", opts)

-- New line up/down without entering insert mode
vim.keymap.set("n", "OO", "O<Esc>k", opts)
vim.keymap.set("n", "oo", "O<Esc>j", opts)

-- Center on movements
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)

-- :wa ? too long!!
vim.keymap.set("n", "<leader>w", ":wa<CR>", opts)
vim.keymap.set("n", "<leader>x", ':lua require("bufdel")<CR> <cmd>BufDel<cr>', opts)
vim.keymap.set("n", "<leader>X", ':lua require("bufdel")<CR> <cmd>BufDelOthers<cr>', opts)

-- Obsidian
vim.keymap.set("n", "<leader>op", ":ObsidianQuickSwitch<CR>", opts)
vim.keymap.set("n", "<leader>of", ":ObsidianSearch<CR>", opts)
vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", opts)

-- Telescope
vim.keymap.set("n", "<leader>b", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)
vim.keymap.set("n", "<leader>f", ':lua require("telescope")<CR> <cmd>Telescope live_grep<cr>', opts)
vim.keymap.set("n", "<leader>p", ':lua require("telescope")<CR> <cmd>Telescope find_files<cr>', opts)
vim.keymap.set("n", "<leader>bb", ':lua require("telescope")<CR> <cmd>Telescope buffers<cr>', opts)
vim.keymap.set("n", "dr", function()
	require("telescope.builtin").lsp_references()
end, opts)

-- Bufferline
vim.keymap.set("n", "<C-j>", ":BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<C-k>", ":BufferLineCyclePrev<CR>", opts)

-- Nvim tree
-- First four of these binds is quickfix for nvimtree bugging out
-- auto-session. Will ensure nvim tree is closed before exiting.
vim.keymap.set("n", ":qa", ":NvimTreeClose<CR>:qa<CR>", opts)
vim.keymap.set("n", ":qa!", ":NvimTreeClose<CR>:qa!<CR>", opts)
vim.keymap.set("n", ":wqa", ":NvimTreeClose<CR>:wa<CR>:qa<CR>", opts)
vim.keymap.set("n", ":wq", ":NvimTreeClose<CR>:wa<CR>:qa<CR>", opts)
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- nvim-spider (w,e,b replacement)
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", opts)
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", opts)
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", opts)
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", opts)

-- Comment
vim.keymap.set("n", "gcc", "<cmd> :lua require('Comment.api').toggle.linewise.current()<CR>", opts)
vim.keymap.set("v", "gc", "<esc><cmd> :lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- LSP
-- vim.keymap.set("n", "gr", function()
-- 	vipls.lsp.buf.references()
-- end, opts)
vim.keymap.set("n", "df", function()
	vim.lsp.buf.definition()
end, opts)
vim.keymap.set("n", "ga", function()
	vim.lsp.buf.code_action()
end, opts)
vim.keymap.set("n", "gh", function()
	vim.diagnostic.open_float({ scope = "line" })
end, opts)
vim.keymap.set("n", "<leader>r", function()
	vim.lsp.buf.rename()
end, opts)

-- DAP
vim.keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>db", function()
	require("dap").toggle_breakpoint()
end)

-- Trouble
-- vim.keymap.set("n", "<leader>t", function()
-- 	require("trouble").toggle()
-- end)
vim.keymap.set("n", "<leadet>t", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>")
vim.keymap.set("n", "<leader>gt", "<cmd>Trouble symbols toggle pinned=true win.relative=win win.position=right<cr>")
vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references toggle <cr>")
