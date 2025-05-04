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
