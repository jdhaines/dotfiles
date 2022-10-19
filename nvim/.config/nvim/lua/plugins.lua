vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end
vim.api.nvim_command("packadd packer.nvim")
-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_setup(name)
  return string.format('require("setup/%s")', name)
end

return require("packer").startup({
  function(use)
    use 'wbthomason/packer.nvim'

    -- allow block movement with alt keys
    use 'fedepujol/move.nvim'

    -- onedark color schemes
    use { 'navarasu/onedark.nvim', config = function()
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
        require 'hop'.setup()
      end
    }

    -- nvim-colorizer
    use 'norcalli/nvim-colorizer.lua'
    require 'colorizer'.setup()

    -- Staline & Stabline
    use { 'tamton-aquib/staline.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    require('staline').setup({
      sections = {
        left  = {
          ' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
          'right_sep', '-file_name', 'left_sep', ' ',
          'right_sep_double', '-branch', 'left_sep_double', ' ',
        },
        mid   = { 'lsp' },
        right = {
          'right_sep', '-cool_symbol', 'left_sep', ' ',
          'right_sep', '- ', '-lsp_name', '- ', 'left_sep',
          'right_sep_double', '-line_column', 'left_sep_double', ' ',
        }
      },
      defaults = {
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
        v  = "#4096D0" -- etc
      }
    })
    require('stabline').setup()

    -- IDE (Treesitter)
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    require 'nvim-treesitter.configs'.setup {
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
    use {
      'williamboman/nvim-lsp-installer',
      'neovim/nvim-lspconfig'
    }
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

    require 'lspconfig'.sumneko_lua.setup {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
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
    require 'lspconfig'.tsserver.setup {}
    require 'lspconfig'.tailwindcss.setup {}

    -- Completions
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/nvim-cmp'

    -- nvim-tree
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    require("nvim-tree").setup({
      auto_reload_on_write = true,
      create_in_closed_folder = false,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      ignore_buffer_on_setup = false,
      open_on_setup = false,
      open_on_setup_file = false,
      open_on_tab = false,
      ignore_buf_on_tab_change = {},
      sort_by = "name",
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = false,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      on_attach = "disable",
      remove_keymaps = false,
      select_prompts = false,
      view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
          custom_only = false,
          list = {
            -- user mappings go here
          },
        },
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = true,
        update_root = false,
        ignore_list = {},
      },
      ignore_ft_on_setup = {},
      system_open = {
        cmd = "",
        args = {},
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        debounce_delay = 50,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = true,
          resize_window = true,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
        require_confirm = true,
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    })

    -- ### All Plugins Above This Line ### --

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})
