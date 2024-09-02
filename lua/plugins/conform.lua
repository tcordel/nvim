return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      markdown = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      xml = { "tidy" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
      tidy = {
        command = "tidy",
        args = {
          "-q",
          "--input-xml",
          "true",
          "--indent",
          "yes",
          "--indent-spaces",
          "4",
        },
        stdin = true,
      },
    },
  },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
}
