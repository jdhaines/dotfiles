-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable :q by remapping to :bd
vim.api.nvim_create_autocmd('CmdlineEnter', {
    desc = "Redirect :q to :bd so nvim window doesn't close",
    pattern = '*',
    callback = function()
        vim.cmd [[
      cnoreabbrev <expr> q getcmdtype() ==# ':' && getcmdline() ==# 'q' ? 'bd' : 'q'
    ]]
    end,
})

-- Remap :wq to just :w
vim.api.nvim_create_autocmd('CmdlineEnter', {
    desc = 'Redirect :wq to :w to avoid closing nvim',
    pattern = '*',
    callback = function()
        vim.cmd [[
      cnoreabbrev <expr> wq getcmdtype() ==# ':' && getcmdline() ==# 'wq' ? 'w' : 'wq'
    ]]
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight yanked text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
