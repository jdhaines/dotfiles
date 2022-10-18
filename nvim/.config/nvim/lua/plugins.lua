----
-- Install & Configure Packer Plugin Manager
----

local settings = require("user-conf")
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
    return string.format('require("config/%s")', name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer...")
    vim.api.nvim_command("packadd packer.nvim")
end

-- initialize and configure packer
local packer = require("packer")

packer.init({
    enable = true, -- enable profiling via :PackerCompile profile=true
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
    -- Have packer use a popup window
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

packer.startup(function(use)
    
    use 'wbthomason/packer.nvim'
    
    -- allow block movement with alt keys
    use 'fedepujol/move.nvim' 
    
    -- onedark color schemes
    use {'navarasu/onedark.nvim', config = function()
        require('onedark').setup {
            style = 'dark' -- dark, darker, cool, deep, warm, warmer, light
        }
        require('onedark').load()
    end,
}

-- vim be good games
use 'ThePrimeagen/vim-be-good'

-- hop (easy-motion & sneak)
use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup() 
    end
}

-- nvim-colorizer
use 'norcalli/nvim-colorizer.lua'
require'colorizer'.setup()
-- 
-- -- lualine
-- use { 'nvim-lualine/lualine.nvim',
-- requires = { 'kyazdani42/nvim-web-devicons', opt = true },
-- config = function()
-- require('lualine').setup({
-- options = {
-- icons_enabled = true,
-- theme = 'onedark',
-- }
-- })
-- end,
-- }

-- Staline & Stabline
use{ 'tamton-aquib/staline.nvim',
requires = { 'kyazdani42/nvim-web-devicons', opt = true },
}
require('staline').setup({
    sections = {
        left = {
            ' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
            'right_sep', '-file_name', 'left_sep', ' ',
            'right_sep_double', '-branch', 'left_sep_double', ' ',
        },
        mid  = {'lsp'},
        right= {
            'right_sep', '-cool_symbol', 'left_sep', ' ',
            'right_sep', '- ', '-lsp_name', '- ', 'left_sep',
            'right_sep_double', '-line_column', 'left_sep_double', ' ',
        }
    },
    defaults={
        fg = "#111111",
        cool_symbol = "  ",
        left_separator = "",
        right_separator = "",
        -- line_column = "%l:%c [%L]",
        true_colors = true,
        line_column = "[%l:%c] 並%p%% "
        -- font_active = "bold"
    },
    mode_colors = {
        n  = "#EBBF6F",
        i  = "#F95B6E",
        ic = "#CF6FDF",
        c  = "#2B848F",
        v  = "#4096D0"       -- etc
    }
})
require('stabline').setup()

-- IDE (Treesitter)
use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
}
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "comment",
        "css",
        "devicetree",
        "dockerfile",
        "dot",
        "fish",
        "gitattributes",
        "gitignore",
        "go",
        "graphql",
        "help",
        "html",
        "http",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonnet",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rego",
        "ruby",
        "rust",
        "scss",
        "sql",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml"
    },
    highlight = { -- enable highlighting
    enable = true,
    },
    indent = {
        enable = true, -- default is disabled anyways
    }
  }

   -- LSP Config
   use 'williamboman/nvim-lsp-installer'
   require("nvim-lsp-installer").setup({
     automatic_installation = true,
     ui = {
       icons = {
         server_installed = "✓",
         server_pending = "➜",
         server_uninstalled = "✗",
       }
     }
   })
 
   use 'neovim/nvim-lspconfig'
   require'lspconfig'.sumneko_lua.setup{
    require'lspconfig'.sumneko_lua.setup{
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      }  
   }
 

-- ### All Plugins Above This Line ### --
-- Automatically set up configuration after cloning packer.nvim
if packer_bootstrap then
    require('packer').sync()
end
end)