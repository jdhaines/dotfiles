require("nvim-treesitter.install").update({ with_sync = true })
require("nvim-treesitter.configs").setup({
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
		"prisma",
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
		"yaml",
	},
	highlight = { -- enable highlighting
		enable = true,
	},
	indent = {
		enable = true, -- default is disabled anyways
	},
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
	callback = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldnestmax = 3
		vim.opt.foldlevel = 99
		vim.opt.foldminlines = 1
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	end,
})
