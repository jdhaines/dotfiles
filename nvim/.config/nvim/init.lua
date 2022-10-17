----
-- keybindings
----

-- Variables - Global
vim.o.scrolloff = 10
vim.g.mapleader = " "
vim.opt.termguicolors = true

-- Variables - Local to Window
vim.wo.cursorline = true
vim.wo.relativenumber = true

-- Variables - Local to Buffer
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2


----
-- keybindings
----

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Alt j & k move lines and blocks
keymap('n', '<A-j>', ':MoveLine(1)<CR>', opts)
keymap('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
  --keymap('n', '<A-h>', ':MoveHChar(-1)<CR>', opts) -- don't want horizontal movement
  --keymap('n', '<A-l>', ':MoveHChar(1)<CR>', opts) -- don't want horizontal movement
keymap('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
keymap('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
  --keymap('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts) -- don't want horizontal movement
  --keymap('v', '<A-l>', ':MoveHBlock(1)<CR>', opts) -- don't want horizontal movement

-- jj works like esc
keymap('i', 'jj', '<Esc>', opts)

-- hop keybindings
keymap('n', '<Leader><Leader>b', '<cmd>HopWordBC<CR>', opts)
keymap('n', '<Leader><Leader>w', '<cmd>HopWordAC<CR>', opts)
keymap('v', '<Leader><Leader>b', '<cmd>HopWordBC<CR>', opts)
keymap('v', '<Leader><Leader>w', '<cmd>HopWordAC<CR>', opts)
keymap('n', 's', '<cmd>HopChar2AC<CR>', opts)
keymap('n', 'S', '<cmd>HopChar2BC<CR>', opts)
keymap('v', 's', '<cmd>HopChar2AC<CR>', opts)
keymap('v', 'S', '<cmd>HopChar2BC<CR>', opts)

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
  -- use 'norcalli/nvim-colorizer.lua'
  -- require'colorizer'.setup()
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
  
  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
