return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "gh",
      function()
        require("telescope.builtin").lsp_incoming_calls()
      end,
      desc = "lsp_incoming_calls",
    },
    {
      "<leader>sf",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Search file",
    },
  },
}
