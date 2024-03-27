return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    opts = function(_, opts)
      opts.cmd = {
        vim.fn.exepath("jdtls"),
        "--jvm-arg=-javaagent:/home/tib/.local/share/java/lombok.jar",
      }
    end,
  },
}
