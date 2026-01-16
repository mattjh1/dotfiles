local options = {
	backend = "ollama",
	model = "codellama:7b",
	url = "http://localhost:8888/api/generate",
	request_body = {
		options = {
			num_predict = 60,
			temperature = 0.2,
			top_p = 0.95,
		},
	},
	tokens_to_clear = { "<EOT>" },
	fim = {
		enabled = true,
		prefix = "<PRE> ",
		middle = " <MID>",
		suffix = " <SUF>",
	},
	context_window = 4096,
	tokenizer = {
		repository = "codellama/CodeLlama-13b-hf",
	},
	debounce_ms = 150,
	accept_keymap = "<S-Tab>",
	dismiss_keymap = "<C-Tab>",
	tls_skip_verify_insecure = false,
	lsp = {
		bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
	},
	enable_suggestions_on_startup = true,

	enable_suggestions_on_files = "*",
}

require("llm").setup(options)
