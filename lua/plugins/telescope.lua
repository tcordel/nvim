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
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
          query = "",
          sorting_strategy = "ascending",
        })
      end,
      desc = "Search symbol",
    },
  },
}
