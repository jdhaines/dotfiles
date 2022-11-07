require("slowly").setup({
  disabled_builtins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
  },
  plugins = {
    -- { url = 'https://github.com/olimorris/onedarkpro.nvim', start = true },
    { url = "https://github.com/shaunsingh/nord.nvim", start = true },
    { url = "https://github.com/ThePrimeagen/vim-be-good", start = true },
    { url = "https://github.com/phaazon/hop.nvim", start = true, checkout = "v2" },
    { url = "https://github.com/norcalli/nvim-colorizer.lua", start = true },
    { url = "https://github.com/kyazdani42/nvim-web-devicons", start = true },
    { url = "https://github.com/tamton-aquib/staline.nvim", start = true },
    { url = "https://github.com/nvim-treesitter/nvim-treesitter", start = true },
    { url = "https://github.com/williamboman/mason.nvim", start = true },
    { url = "https://github.com/williamboman/mason-lspconfig.nvim", start = true },
    { url = "https://github.com/jose-elias-alvarez/null-ls.nvim", start = true },
    -- { url = "https://github.com/jayp0521/mason-null-ls.nvim", start = true },
    -- { url = "https://github.com/mhartington/formatter.nvim", start = true },
    { url = "https://github.com/neovim/nvim-lspconfig", start = true },
    { url = "https://github.com/hrsh7th/cmp-nvim-lsp", start = true },
    { url = "https://github.com/hrsh7th/cmp-buffer", start = true },
    { url = "https://github.com/hrsh7th/cmp-path", start = true },
    { url = "https://github.com/hrsh7th/cmp-cmdline", start = true },
    { url = "https://github.com/hrsh7th/cmp-nvim-lua", start = true },
    { url = "https://github.com/hrsh7th/nvim-cmp", start = true },
    { url = "https://github.com/nvim-tree/nvim-tree.lua", start = true, checkout = "nightly" },
    { url = "https://github.com/nvim-telescope/telescope.nvim", start = true },
    { url = "https://github.com/nvim-lua/plenary.nvim", start = true },
    { url = "https://github.com/ahmedkhalf/project.nvim", start = true },
    { url = "https://github.com/lewis6991/gitsigns.nvim", start = true, checkout = "release" },
    { url = "https://github.com/terrortylor/nvim-comment", start = true },
    { url = "https://github.com/andweeb/presence.nvim", start = true },
    { url = "https://github.com/fedepujol/move.nvim", start = true },
  },
})

-- Plugins
-- require("plugins.onedarkpro")
require("plugins.nord")
require("plugins.hop")
require("plugins.colorizer")
require("plugins.staline")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.cmp")
require("plugins.nvim-tree")
require("plugins.telescope")
require("plugins.project")
require("plugins.gitsigns")
require("plugins.comment")
require("plugins.presence")

-- All non plugin related (vim) options
require("options")

-- Vim Keybindingds
require("mappings")
