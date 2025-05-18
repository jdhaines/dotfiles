require 'core.autocmds'
require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup {
  require 'plugins.colortheme',
  require 'plugins.neotree',
  require 'plugins.snacks',
  require 'plugins.autopairs',
  require 'plugins.lualine',
  require 'plugins.cellularfml',
  require 'plugins.harpoon',
  require 'plugins.vertical',
  require 'plugins.wakatime',
  require 'plugins.gitsigns',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.indentblankline',
  require 'plugins.lsp',
  require 'plugins.autoformatting',
  require 'plugins.whichkey',
  require 'plugins.colorizer',
  require 'plugins.copilot',
  require 'plugins.obsidian',

  -- pick nvim_cmp OR blink... not both

  -- require 'plugins.autocompletion_nvim',

  require 'plugins.autocompletion_blink',
  require 'plugins.copilot_blink',
}
