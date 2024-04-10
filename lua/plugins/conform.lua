return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    lang_to_formatters = {
      json = { "jq" },
      xml = { "xmlfomat" },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      markdown = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      xml = { "xmlfomat" },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
