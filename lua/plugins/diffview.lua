local wk = require("which-key")
wk.register({
    ["<leader>gd"] = { name = "+diffview" },
    ["<leader>gh"] = { name = "+hunks" },
})
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
		{ "<leader>ghB", function() require("gitsigns").blame() end,  desc = "Blame File" },
  },
}
