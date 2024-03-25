return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "jdtls", "typescript-language-server" })
    end,
  },
  "williamboman/mason-lspconfig.nvim",
}
