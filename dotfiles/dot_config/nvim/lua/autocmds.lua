local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local filetypedetect_group = augroup("filetypedetect", { clear = true })

-- Check if html file contains go templating (hugo), treat as go template then
autocmd({ "BufRead", "BufNewFile", "BufReadPost", "BufWinEnter" }, {
	pattern = "*.html",
	group = filetypedetect_group,
	callback = function()
		if vim.fn.expand("%:e") == "html" then
			if vim.fn.search("{{", "nw") ~= 0 then
				vim.b.is_hugo_template = true
			end
		end
	end,
})

vim.filetype.add({
	extension = {
		html = function(_, bufnr)
			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			for _, line in ipairs(lines) do
				if line:match("{{.*}}") then
					return "gohtmltmpl"
				end
			end
			return "html"
		end,
	},
})

autocmd("VimEnter", {
	group = filetypedetect_group,
	callback = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[buf].buftype == "" and vim.api.nvim_buf_is_loaded(buf) then
				local filename = vim.api.nvim_buf_get_name(buf)
				if filename:match("%.html$") and vim.fn.search("{{", "nw", buf) ~= 0 then
					vim.bo[buf].filetype = "gohtmltmpl"
				end
			end
		end
	end,
})

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
autocmd("InsertEnter", {
	callback = function()
		vim.opt.relativenumber = false
	end,
})

autocmd("InsertLeave", {
	callback = function()
		vim.opt.relativenumber = true
	end,
})

-- Highlight yanked text
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
	end,
})

-- Enable spellchecking in markdown, text and gitcommit files
autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "text", "tex" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- Markdown

-- Create augroup for markdown settings
local markdown_group = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })

-- Markdown-specific settings
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
	group = markdown_group,
	pattern = { "markdown", "md" },
	callback = function()
		-- Line wrapping settings
		vim.wo.wrap = true
		vim.wo.linebreak = true
		vim.wo.breakindent = true
		vim.wo.showbreak = "↪ "

		-- Buffer-local settings
		vim.bo.textwidth = 0 -- No hard wrapping
		vim.bo.wrapmargin = 0

		-- Optional: concealing for cleaner view
		vim.wo.conceallevel = 2
		vim.wo.concealcursor = "nc"

		-- Spell checking
		vim.wo.spell = true
		vim.bo.spelllang = "en_us"

		-- Better navigation for wrapped lines
		vim.keymap.set("n", "j", "gj", { buffer = true, silent = true })
		vim.keymap.set("n", "k", "gk", { buffer = true, silent = true })
		vim.keymap.set("n", "0", "g0", { buffer = true, silent = true })
		vim.keymap.set("n", "$", "g$", { buffer = true, silent = true })

		-- Quick formatting keybinds
		local opts = { buffer = true, silent = true }
		vim.keymap.set("n", "<leader>mb", 'ciw**<C-r>"**<Esc>', opts) -- Bold word
		vim.keymap.set("n", "<leader>mi", 'ciw*<C-r>"*<Esc>', opts) -- Italic word
		vim.keymap.set("v", "<leader>mb", 'c**<C-r>"**<Esc>', opts) -- Bold selection
		vim.keymap.set("v", "<leader>mi", 'c*<C-r>"*<Esc>', opts) -- Italic selection

		-- Toggle checkboxes
		vim.keymap.set("n", "<leader>tc", function()
			local line = vim.api.nvim_get_current_line()
			local new_line
			if line:match("^%s*- %[ %]") then
				new_line = line:gsub("- %[ %]", "- [x]", 1)
			elseif line:match("^%s*- %[x%]") then
				new_line = line:gsub("- %[x%]", "- [ ]", 1)
			elseif line:match("^%s*- ") then
				new_line = line:gsub("^(%s*)- ", "%1- [ ] ", 1)
			else
				return
			end
			vim.api.nvim_set_current_line(new_line)
		end, opts)
	end,
})

-- Additional settings for Obsidian vault files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = markdown_group,
	pattern = { "*/vault/*", "*/Notes/*", "*sos-alarm-notes*" },
	callback = function()
		-- Extra settings specific to note-taking
		vim.wo.number = false -- Hide line numbers for cleaner notes
		vim.wo.relativenumber = false
		vim.wo.signcolumn = "no" -- Hide sign column

		-- Zen mode-like settings
		vim.wo.colorcolumn = "" -- No column markers

		print("Obsidian vault detected - optimized for note-taking")
	end,
})
