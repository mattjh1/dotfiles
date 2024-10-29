local autocmd = vim.api.nvim_create_autocmd

-- Check if html file contains go templating (hugo), treat as go template then
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.html",
	callback = function()
		if vim.fn.expand("%:e") == "html" then
			if vim.fn.search("{{", "nw") ~= 0 then
				vim.bo.filetype = "gohtmltmpl"
			end
		end
	end,
	group = vim.api.nvim_create_augroup("filetypedetect", { clear = true }),
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
