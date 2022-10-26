require('slowly').setup({
  disabled_builtins = {
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers'
  },
  plugins = {
    { url = 'https://github.com/olimorris/onedarkpro.nvim', start = true },
    { url = 'https://github.com/ThePrimeagen/vim-be-good', start = true },
    { url = 'https://github.com/phaazon/hop.nvim', start = true, checkout = 'v2' },
    { url = 'https://github.com/norcalli/nvim-colorizer.lua', start = true },
    { url = 'https://github.com/kyazdani42/nvim-web-devicons', start = true },
    { url = 'https://github.com/tamton-aquib/staline.nvim', start = true },
    { url = 'https://github.com/nvim-treesitter/nvim-treesitter', start = true },
    { url = 'https://github.com/williamboman/nvim-lsp-installer', start = true },
    { url = 'https://github.com/neovim/nvim-lspconfig', start = true },
    { url = 'https://github.com/hrsh7th/cmp-nvim-lsp', start = true },
    { url = 'https://github.com/hrsh7th/cmp-buffer', start = true },
    { url = 'https://github.com/hrsh7th/cmp-path', start = true },
    { url = 'https://github.com/hrsh7th/cmp-cmdline', start = true },
    { url = 'https://github.com/hrsh7th/cmp-nvim-lua', start = true },
    { url = 'https://github.com/hrsh7th/nvim-cmp', start = true },
    { url = 'https://github.com/nvim-tree/nvim-tree.lua', start = true, checkout = 'nightly' },
    { url = 'https://github.com/nvim-telescope/telescope.nvim', start = true },
    { url = 'https://github.com/nvim-lua/plenary.nvim', start = true },
    { url = 'https://github.com/ahmedkhalf/project.nvim', start = true },
    { url = 'https://github.com/lewis6991/gitsigns.nvim', start = true, checkout = 'release' },
    { url = 'https://github.com/terrortylor/nvim-comment', start = true },
    { url = 'https://github.com/andweeb/presence.nvim', start = true },
    { url = 'https://github.com/fedepujol/move.nvim', start = true },
  }
})

-- Vim mappings, see lua/config/which.lua for more mappings
require("mappings")

-- All non plugin related (vim) options
require("options")

-- Plugins
require("plugins.onedarkpro")
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

