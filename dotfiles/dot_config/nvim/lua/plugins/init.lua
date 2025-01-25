local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	performance = {
		rtp = {
			reset = false,
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	defaults = { lazy = false },
	"rafamadriz/friendly-snippets",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"ojroques/nvim-bufdel",
	"ahmedkhalf/project.nvim",
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.obsidian")
		end,
	},
	{ "mfussenegger/nvim-dap" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "nvim-neotest/nvim-nio" },
	{ "rcarriga/nvim-dap-ui" },
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"mfussenegger/nvim-dap-python",
			"nvim-telescope/telescope-dap.nvim",
			"nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("plugins.debuggers")
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("plugins.nvim-tree")
		end,
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("plugins.auto-session")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			require("plugins.harpoon")
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			focus = true,
			modes = {
				test = {
					mode = "diagnostics",
					preview = {
						type = "split",
						relative = "win",
						position = "right",
						size = 0.3,
					},
				},
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("plugins.treesitter")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		config = function()
			require("plugins.treesitter-textobjects")
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("plugins.mason")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lspconfig")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		config = function()
			require("plugins.cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		lazy = true,
		dependencies = { "onsails/lspkind.nvim", "rafamadriz/friendly-snippets" },
		run = "make install_jsregexp",
		config = function()
			require("plugins.luasnip")
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.gitsigns")
		end,
	},
	{
		lazy = true,
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "v4.*",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build =
		"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
	},
	{
		lazy = true,
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	},
	{
		lazy = true,
		"chrisgrieser/nvim-spider",
	},
	{
		lazy = false,
		"gbprod/nord.nvim",
		config = function()
			require("plugins.nord")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.lualine")
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		config = function()
			require("plugins.none-ls")
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
})
