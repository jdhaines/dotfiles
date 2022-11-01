----
-- keybindings
----

-- Variables - Global
vim.o.scrolloff = 10
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.splitbelow = true
vim.g.splitright = true
vim.g.smarttab = true
vim.g.tabstop = 8
vim.g.shiftwidth = 2
vim.g.softtabstop = 0
vim.g.expandtab = true

-- Variables - Local to Window
vim.wo.cursorline = true
vim.wo.relativenumber = true
vim.wo.number = true

-- Variables - Local to Buffer


----
-- keymappings
----

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)

--Remap space as leader key
keymap("n", "<Space>", "<Nop>", opts)
keymap("v", "<Space>", "<Nop>", opts)

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
-- keymap('n', '<Leader><Leader>b', '<cmd>HopWordBC<CR>', opts)
keymap('n', '<Leader>w', '<cmd>HopWordMW<CR>', opts)
-- keymap('v', '<Leader><Leader>b', '<cmd>HopWordBC<CR>', opts)
keymap('v', '<Leader>w', '<cmd>HopWordMW<CR>', opts)
-- keymap('n', 's', '<cmd>HopChar2AC<CR>', opts)
-- keymap('n', 'S', '<cmd>HopChar2BC<CR>', opts)
-- keymap('v', 's', '<cmd>HopChar2AC<CR>', opts)
-- keymap('v', 'S', '<cmd>HopChar2BC<CR>', opts)

-- LSP Keybindings
keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', opts)
keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>', opts)
keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>', opts)
keymap('n', 'gw', ':lua vim.lsp.buf.document_symbol()<cr>', opts)
keymap('n', 'gw', ':lua vim.lsp.buf.workspace_symbol()<cr>', opts)
keymap('n', 'gr', ':lua vim.lsp.buf.references()<cr>', opts)
keymap('n', 'gt', ':lua vim.lsp.buf.type_definition()<cr>', opts)
keymap('n', 'K', ':lua vim.lsp.buf.hover()<cr>', opts)
keymap('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<cr>', opts)
keymap('n', '<leader>af', ':lua vim.lsp.buf.code_action()<cr>', opts)
keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<cr>', opts)

-- nvim-tree Keybindings
keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)
keymap('v', '<leader>e', ':NvimTreeToggle<cr>', opts)

-- Telescope Keybindings
keymap('n', '<leader>f', ':Telescope find_files<cr>', opts)
keymap('n', '<leader>g', ':Telescope live_grep<cr>', opts)
keymap('n', '<leader>c', ':Telescope git_commits<cr>', opts)

-- Better new lines without comments
keymap('n', 'o', 'o<Esc>^Da', opts)
keymap('n', 'O', 'O<Esc>^Da', opts)

-- Format Document
keymap('n', '<leader>F', ':FormatWrite<CR>', opts)


