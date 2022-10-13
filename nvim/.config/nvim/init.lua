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
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)

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
  
  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
