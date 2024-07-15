local wk = require("which-key")
wk.add({ "<leader>gd", group = "diffview" }, { "<leader>gh", group = "hunks" })
return {
  "sindrets/diffview.nvim",
  keys = {
    {
      "<leader>gdl",
      "<Cmd>DiffviewFileHistory<CR>",
      desc = "Log",
    },
    {
      "<leader>gdL",
      "<Cmd>DiffviewFileHistory %<CR>",
      desc = "Log File",
    },
    {
      "<leader>gdo",
      "<Cmd>DiffviewOpen<CR>",
      desc = "diffview open",
    },
    {
      "<leader>gdc",
      "<Cmd>DiffviewClose<CR>",
      desc = "diffview close",
    },
    {
      "<leader>ghB",
      function()
        require("gitsigns").blame()
      end,
      desc = "Blame File",
    },
  },
}
