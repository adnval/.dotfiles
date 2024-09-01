return {
  "folke/trouble.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Open/close trouble list" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Open trouble document diagnostics" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Open trouble quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Open trouble location list" },
    { "<leader>xt", "<cmd>TodoTrouble toggle<cr>", desc = "Open todos in trouble" },
  },
}
