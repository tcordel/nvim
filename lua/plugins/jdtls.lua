return {
  "mfussenegger/nvim-jdtls",
  dependencies = { "folke/which-key.nvim" },
  keys = {
    {
      "<leader>ci",
      function()
        require("jdtls").organize_imports()
      end,
      desc = "Organize Imports",
    },
    {
      "<leader>ce",
      function()
        require("jdtls").extract_variable()
      end,
      desc = "Extract Variable",
    },
    {
      "<leader>cf",
      function()
        vim.lsp.buf.formatting()
      end,
      desc = "Format",
    },
  },
  opts = function(_, opts)
    opts.cmd = {
      vim.fn.exepath("jdtls"),
      "--jvm-arg=-javaagent:/home/tib/.local/share/java/lombok.jar",
    }
  end,
}
