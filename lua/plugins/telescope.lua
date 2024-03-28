return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fh",
        function()
          require("telescope.builtin").lsp_incoming_calls()
        end,
        desc = "Find Hierarchy",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
}
