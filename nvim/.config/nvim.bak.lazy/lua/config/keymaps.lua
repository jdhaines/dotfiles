-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Mapping helper
local mapper = function(mode, key, result)
  vim.keymap.set(mode, key, result, { noremap = true, silent = true })
end
--
-- -- Cancel search highlighting with ESC
mapper("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>")
--
-- --Remap space as leader key
-- --mapper("n", "<Space>", "<Nop>")
-- --mapper("v", "<Space>", "<Nop>")
--
-- -- hop keybindings
-- mapper("n", "<Leader>w", "<cmd>HopWordMW<CR>")
-- mapper("v", "<Leader>w", "<cmd>HopWordMW<CR>")
--
-- -- jj works like esc
mapper("i", "jj", "<Esc>")

--
-- -- Alt j & k move lines and blocks
-- mapper("n", "<A-j>", ":MoveLine(1)<CR>")
-- mapper("n", "<A-k>", ":MoveLine(-1)<CR>")
-- mapper("v", "<A-j>", ":MoveBlock(1)<CR>")
-- mapper("v", "<A-k>", ":MoveBlock(-1)<CR>")
--
-- -- nvim-tree Keybindings
-- mapper("n", "<leader>e", ":NvimTreeToggle<cr>")
-- mapper("v", "<leader>e", ":NvimTreeToggle<cr>")
--
-- -- Telescope Keybindings
mapper(
  "n",
  "<leader>ff",
  "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>"
)
-- set leader space to find files in cwd (failed attempt)
-- vim.keymap.del("n", "<leader><Space>", {})
-- mapper(
--   "n",
--   "<leader><Space>",
--   "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>"
-- )
-- mapper("n", "<leader>f", ":Telescope find_files hidden=true<cr>")
-- mapper("n", "<leader>g", ":Telescope live_grep<cr>")
-- mapper("n", "<leader>c", ":Telescope git_commits<cr>")
--
-- -- Better new lines without comments
mapper("n", "o", "o<Esc>^Da")
mapper("n", "O", "O<Esc>^Da")
--
-- -- Center screen after moving down or up
mapper("n", "<C-d>", "<C-d>zz")
mapper("n", "<C-u>", "<C-u>zz")
--
-- -- Format Document
mapper("n", "<leader>F", "<cmd>lua vim.lsp.buf.format()<cr>")
-- mapper("n", "<leader>F", ":FormatWrite<CR>")
--
-- -- LSP Keybindings
-- mapper("n", "gd", ":lua vim.lsp.buf.definition()<cr>")
-- mapper("n", "gD", ":lua vim.lsp.buf.declaration()<cr>")
-- mapper("n", "gi", ":lua vim.lsp.buf.implementation()<cr>")
-- mapper("n", "gw", ":lua vim.lsp.buf.document_symbol()<cr>")
-- mapper("n", "gw", ":lua vim.lsp.buf.workspace_symbol()<cr>")
-- mapper("n", "gr", ":lua vim.lsp.buf.references()<cr>")
-- mapper("n", "ge", ":lua vim.diagnostic.open_float()<cr>")
-- mapper("n", "gt", ":lua vim.lsp.buf.type_definition()<cr>")
-- mapper("n", "K", ":lua vim.lsp.buf.hover()<cr>")
-- mapper("n", "<c-k>", ":lua vim.lsp.buf.signature_help()<cr>")
-- mapper("n", "<leader>af", ":lua vim.lsp.buf.code_action()<cr>")
-- mapper("n", "<leader>rn", ":lua vim.lsp.buf.rename()<cr>")

-- -- Make It Rain
mapper("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- -- Harpoon Keybindings
-- mapper("n", "<leader>hm", "function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)")
