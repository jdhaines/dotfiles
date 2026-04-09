return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    ts.setup {
      install_dir = vim.fn.stdpath 'data' .. '/site',
    }

    ts.install {
      'bash',
      'css',
      'diff',
      'dockerfile',
      'fish',
      'gitignore',
      'graphql',
      'go',
      'html',
      'javascript',
      'json',
      'lua',
      'luadoc',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'sql',
      'typescript',
      'terraform',
      'toml',
      'tsx',
      'vim',
      'vimdoc',
      'vue',
      'yaml',
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if not ok then
          return
        end

        if vim.bo[args.buf].filetype ~= 'ruby' then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
