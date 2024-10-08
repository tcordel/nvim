local wk = require("which-key")
wk.add({ "<leader>gg", group = "gitlab" })
return {
  "harrisoncramer/gitlab.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
    "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
  },
  enabled = true,
  keys = {
    {
      "<leader>ggr",
      function()
        require("gitlab").review()
      end,
      desc = "review",
    },
    {
      "<leader>ggs",
      function()
        require("gitlab").summary()
      end,
      desc = "summary",
    },
    {
      "<leader>ggc",
      function()
        require("gitlab").create_comment()
      end,
      desc = "create comment",
    },
    {
      "<leader>ggC",
      function()
        require("gitlab").create_multiline_comment()
      end,
      mode = { "v" },
      desc = "create multiline comment",
    },
    {
      "<leader>ggd",
      function()
        require("gitlab").toggle_discussions()
      end,
      desc = "toggle_discussions",
    },
  },
  build = function()
    require("gitlab.server").build(true)
  end, -- builds the go binary
  config = function()
    require("gitlab").setup({
      reviewer_settings = {
        diffview = {
          imply_local = true, -- If true, will attempt to use --imply_local option when calling |:DiffviewOpen|
        },
      },
      connection_settings = {
        insecure = true, -- Like curl's --insecure option, ignore bad x509 certificates on connection
      },
    })
  end,
}
