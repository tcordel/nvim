return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    keys = {
      {
        "<leader>ct",
        function()
          require("jdtls.tests").generate()
        end,
        ft = "java",
        desc = "Create test",
      },
      {
        "<leader>cgt",
        function()
          require("jdtls.tests").goto_subjects()
        end,
        ft = "java",
        desc = "Go to test",
      },
    },

    opts = function(_, opts)
      opts.cmd = {
        vim.fn.exepath("jdtls"),
        "--jvm-arg=-javaagent:" .. require("mason-registry").get_package("jdtls"):get_install_path() .. "/lombok.jar",
      }
    end,
  },
}
