-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- disable :q and remap :wq to :w
-- This is to prevent closing my nvim window while using the new tmux workflow.
-- Remap :q to :bd (close buffer instead of quitting)
vim.cmd([[
  cnoreabbrev <expr> q getcmdtype() == ':' && getcmdline() == 'q' ? 'bd' : 'q'
]])

-- Remap :wq to :w (write but don’t quit)
vim.cmd([[
  cnoreabbrev <expr> wq getcmdtype() == ':' && getcmdline() == 'wq' ? 'w' : 'wq'
]])
