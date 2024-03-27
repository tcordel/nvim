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
        "--jvm-arg=-javaagent:/home/tib/.local/share/java/lombok.jar",
      }
      --      opts.settings = {
      --        java = {
      --          format = {
      --            settings = {
      --              url = "/home/tib/.config/nvim/resources/eno_code_formatter_java.xml",
      --            },
      --          },
      --        },
      --      }
    end,
  },
}
