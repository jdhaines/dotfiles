-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.lazyvim_check_order = false

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- Make 'jj' work like esc
vim.keymap.set('i', 'jj', '<Esc>', opts)

-- Better new lines without comments
vim.keymap.set('n', 'o', 'o<Esc>^Da', opts)
vim.keymap.set('n', 'O', 'O<Esc>^Da', opts)

-- Center screen after moving down or up
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Alt j & k move lines and blocks
vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)

-- Format Document
vim.keymap.set('n', '<leader>F', '<cmd>lua vim.lsp.buf.format()<cr>', opts)

-- Make it Rain (Cellular FML)
vim.keymap.set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Fully Disable Mouse
vim.keymap.set('', '<up>', '<nop>', { noremap = true })
vim.keymap.set('', '<down>', '<nop>', { noremap = true })
vim.keymap.set('i', '<up>', '<nop>', { noremap = true })
vim.keymap.set('i', '<down>', '<nop>', { noremap = true })

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Obsidian
vim.keymap.set('n', 'gf', function()
  if require('obsidian').util.cursor_on_markdown_link() then
    return '<cmd>ObsidianFollowLink<CR>'
  else
    return 'gf'
  end
end, { noremap = false, expr = true })
