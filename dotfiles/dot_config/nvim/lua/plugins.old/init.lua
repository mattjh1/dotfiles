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
  
  -- Simple plugins without versions (rarely breaking)
  "ojroques/nvim-bufdel", -- ojroques/nvim-bufdel
  "ahmedkhalf/project.nvim", -- ahmedkhalf/project.nvim
  
  {
    "obsidian-nvim/obsidian.nvim", -- obsidian-nvim/obsidian.nvim
    version = "^3.13.0",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim", -- nvim-lua/plenary.nvim
    },
    config = function()
      require("plugins.obsidian")
    end,
  },
  
  {
    "ellisonleao/glow.nvim", -- ellisonleao/glow.nvim (no releases)
    cmd = "Glow",
    ft = { "markdown" },
    config = function()
      require("glow").setup({
        style = "dark", -- "dark" or "light"
        width = 120,
        height = 100,
        width_ratio = 0.8,
        height_ratio = 0.8,
      })
    end,
  },
  
  {
    "mfussenegger/nvim-dap", -- mfussenegger/nvim-dap
    version = "^0.10.0",
    ft = { "python" },
    cmd = {
      "DapToggleBreakpoint",
      "DapContinue",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    dependencies = {
      "mfussenegger/nvim-dap-python", -- mfussenegger/nvim-dap-python
      "nvim-telescope/telescope-dap.nvim", -- nvim-telescope/telescope-dap.nvim
      "rcarriga/nvim-dap-ui", -- rcarriga/nvim-dap-ui
      "nvim-neotest/nvim-nio", -- nvim-neotest/nvim-nio
    },
    config = function()
      require("plugins.debuggers")
    end,
  },
  
  {
    "folke/noice.nvim", -- folke/noice.nvim
    version = "^4.10.0",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim", -- MunifTanjim/nui.nvim
      "rcarriga/nvim-notify", -- rcarriga/nvim-notify
    },
    config = function()
      require("plugins.noice")
    end,
  },
  
  {
    "nvim-tree/nvim-tree.lua", -- nvim-tree/nvim-tree.lua (has weird tag format)
    cmd = "NvimTreeToggle",
    version = "*", -- Keep as * due to unusual tag format
    dependencies = {
      "kyazdani42/nvim-web-devicons", -- kyazdani42/nvim-web-devicons
    },
    config = function()
      require("plugins.nvim-tree")
    end,
  },
  
  {
    "rmagatti/auto-session", -- rmagatti/auto-session (no releases)
    config = function()
      require("plugins.auto-session")
    end,
  },
  
  {
    "ThePrimeagen/harpoon", -- ThePrimeagen/harpoon (branch-based)
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("plugins.harpoon")
    end,
  },
  
  {
    "kdheepak/lazygit.nvim", -- kdheepak/lazygit.nvim (no releases)
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- nvim-lua/plenary.nvim
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  
  {
    "folke/trouble.nvim", -- folke/trouble.nvim
    version = "^3.7.0",
    cmd = { "TroubleToggle", "Trouble" },
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
    "kylechui/nvim-surround", -- kylechui/nvim-surround
    version = "^3.1.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  
  {
    "nvim-treesitter/nvim-treesitter", -- nvim-treesitter/nvim-treesitter (no releases)
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    -- dependencies = {
    --   "nvim-treesitter/nvim-treesitter-textobjects", -- nvim-treesitter/nvim-treesitter-textobjects
    -- },
    config = function()
      require("plugins.treesitter")
    end,
  },
  
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects", -- nvim-treesitter/nvim-treesitter-textobjects
  --   event = "BufReadPost",
  --   config = function()
  --     require("plugins.treesitter-textobjects")
  --   end,
  -- },
  
  {
    "williamboman/mason.nvim", -- williamboman/mason.nvim (no releases)
    cmd = "Mason",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason-lspconfig.nvim", -- williamboman/mason-lspconfig.nvim
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- WhoIsSethDaniel/mason-tool-installer.nvim
    },
    config = function()
      require("plugins.mason")
    end,
  },
  
  {
    "neovim/nvim-lspconfig", -- neovim/nvim-lspconfig
    version = "^2.4.0",
    event = { "BufReadPre", "BufNewFile" },  -- ✅ load before opening a buffer
    config = function()
      require("plugins.lspconfig")
    end,
  },
  
  {
    "hrsh7th/nvim-cmp", -- hrsh7th/nvim-cmp
    version = "^0.0.2",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lua", -- hrsh7th/cmp-nvim-lua
      "hrsh7th/cmp-nvim-lsp", -- hrsh7th/cmp-nvim-lsp
      "hrsh7th/cmp-path", -- hrsh7th/cmp-path
      "saadparwaiz1/cmp_luasnip", -- saadparwaiz1/cmp_luasnip
    },
    config = function()
      require("plugins.cmp")
    end,
  },
  
  {
    "L3MON4D3/LuaSnip", -- L3MON4D3/LuaSnip
    version = "^2.4.0",
    event = "InsertEnter",
    dependencies = { "onsails/lspkind.nvim", "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp", -- Fixed: was 'run'
    config = function()
      require("plugins.luasnip")
    end,
  },
  
  {
    "ray-x/lsp_signature.nvim", -- ray-x/lsp_signature.nvim
    config = function()
      require("lsp_signature").setup()
    end,
  },
  
  {
    "lukas-reineke/indent-blankline.nvim", -- lukas-reineke/indent-blankline.nvim
    version = "^3.9.0",
    main = "ibl",
    opts = {},
  },
  
  {
    "lewis6991/gitsigns.nvim", -- lewis6991/gitsigns.nvim
    version = "^1.0.0",
    config = function()
      require("plugins.gitsigns")
    end,
  },
  
  {
    "numToStr/Comment.nvim", -- numToStr/Comment.nvim
    version = "^0.8.0",
    keys = { "gc", "gb" },
    config = function()
      require("Comment").setup()
    end,
  },
  
  {
    "norcalli/nvim-colorizer.lua", -- norcalli/nvim-colorizer.lua
    config = function()
      require("colorizer").setup()
    end,
  },
  
  {
    "akinsho/bufferline.nvim", -- akinsho/bufferline.nvim
    version = "^4.9.0",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.bufferline")
    end,
  },
  
  {
    "nvim-telescope/telescope-fzf-native.nvim", -- nvim-telescope/telescope-fzf-native.nvim
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  
  {
    "nvim-telescope/telescope-file-browser.nvim", -- nvim-telescope/telescope-file-browser.nvim
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
  },
  
  {
    "nvim-telescope/telescope.nvim", -- nvim-telescope/telescope.nvim
    version = "^0.1.8",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim", -- nvim-telescope/telescope-ui-select.nvim
    },
    config = function()
      require("plugins.telescope")
    end,
  },
  
  {
    "chrisgrieser/nvim-spider", -- chrisgrieser/nvim-spider
    event = "VeryLazy",
  },
  
  {
    lazy = false,
    "gbprod/nord.nvim", -- gbprod/nord.nvim
    version = "^1.1.0",
    config = function()
      require("plugins.nord")
    end,
  },
  
  {
    "nvim-lualine/lualine.nvim", -- nvim-lualine/lualine.nvim (no releases)
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("plugins.lualine")
    end,
  },
  
  {
    "windwp/nvim-autopairs", -- windwp/nvim-autopairs (no releases)
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {},
  },
  
  {
    "nvimtools/none-ls.nvim", -- nvimtools/none-ls.nvim (no releases)
    event = "BufReadPre",
    dependencies = {
      "nvimtools/none-ls-extras.nvim", -- nvimtools/none-ls-extras.nvim
      "jay-babu/mason-null-ls.nvim", -- jay-babu/mason-null-ls.nvim
    },
    config = function()
      require("plugins.none-ls")
    end,
  },
  
  {
    "ray-x/go.nvim", -- ray-x/go.nvim
    version = "^0.10.4",
    dependencies = {
      "ray-x/guihua.lua", -- ray-x/guihua.lua
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
})
