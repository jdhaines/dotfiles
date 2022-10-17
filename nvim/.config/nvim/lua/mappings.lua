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
-- keymappings
----

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)

--Remap space as leader key
keymap({ "n", "v" }, "<Space>", "<Nop>", opts)

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