require("mason").setup({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "jsonls",
    "marksman",
    "prismals",
    "lua_ls",
    "tailwindcss",
    "tsserver",
    "volar",
    "yamlls",
    "terraformls"
  },
})

require("lspconfig").jsonls.setup({})
require("lspconfig").marksman.setup({})
require("lspconfig").prismals.setup({})
-- require("lspconfig").sumneko_lua.setup({})
require("lspconfig").lua_ls.setup({})
require("lspconfig").tailwindcss.setup({})
require("lspconfig").tsserver.setup({})
require("lspconfig").volar.setup({})
require("lspconfig").yamlls.setup({})
require("lspconfig").terraformls.setup({})

local null_ls = require("null-ls")

--formatting sources
-- local formatting = null_ls.builtins.formatting

local sources = {
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.yamlfmt,
}

null_ls.setup({ sources = sources })

-- require("null-ls").setup()
-- require('mason-null-ls').setup({
--   ensure_installed = { 'stylua', 'jq', 'yamlfmt' },
--   automatic_setup = true
-- })

-- -- formatting
-- -- Utilities for creating configurations
-- local util = require("formatter.util")
--
-- -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
-- require("formatter").setup({
-- 	-- Enable or disable logging
-- 	logging = true,
-- 	-- Set the log level
-- 	log_level = vim.log.levels.WARN,
-- 	filetype = {
-- 		lua = {
-- 			require("formatter.filetypes.lua").stylua,
-- 		},
-- 		typescript = {
-- 			require("formatter.filetypes.typescript").prettier,
-- 		},
-- 		yaml = {
-- 			require("formatter.filetypes.yaml").yamlfmt,
-- 		},
-- 	},
-- })
