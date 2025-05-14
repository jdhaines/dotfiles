return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    { "<leader>E", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
  },
  opts = {
    filesystem = {
      bind_to_cwd = false,
      filtered_items = {
        hide_dotfiles = false,
      },
    },
    window = {
      position = "float",
    },
  },
}
