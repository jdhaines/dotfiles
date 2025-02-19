return {
  --   { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
  --   { "<leader>hr", "<cmd>lua require('harpoon.mark').rm_file()<cr>", desc = "Mark file with harpoon" },
  --   { "<leader>hh", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
  --   { "<leader>hj", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous harpoon mark" },
  --   { "<leader>hm", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },

  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        "<leader>ha",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Add File to Harpoon",
      },
      {
        "<leader>hr",
        function()
          require("harpoon"):list():remove()
        end,
        desc = "Remove File from Harpoon",
      },
      {
        "<leader>hh",
        function()
          require("harpoon"):list():next()
        end,
        desc = "Next Harpoon File",
      },
      {
        "<leader>hj",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "Previous Harpoon File",
      },
      {
        "<leader>hm",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Toggle Harpoon Quick Menu",
      },
    }
    return keys
  end,
}
