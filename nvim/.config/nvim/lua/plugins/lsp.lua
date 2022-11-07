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
    "sumneko_lua",
    "tsserver",
    "tailwindcss",
    "marksman",
    "yamlls",
    "prismals",
    "jsonls",
  },
})

require("lspconfig").sumneko_lua.setup({})
require("lspconfig").tsserver.setup({})
require("lspconfig").tailwindcss.setup({})
require("lspconfig").marksman.setup({})
require("lspconfig").yamlls.setup({})
require("lspconfig").sumneko_lua.setup({})
require("lspconfig").jsonls.setup({})
require("lspconfig").prismals.setup({})

require("null-ls").setup()
require("mason-null-ls").setup({
  automatic_setup = true,
})

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
-- 	},
-- })
