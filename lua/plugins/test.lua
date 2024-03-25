return {
  { "vim-test/vim-test" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
      "rcasia/neotest-java",
      "nvim-neotest/neotest-vim-test",
    },
    requires = {
      "nvim-neotest/neotest-jest",
    },
    keys = {
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tL",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Debug Last Test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run Test file",
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "yarn test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          --          require("neotest-java")({
          --            ignore_wrapper = true, -- whether to ignore maven/gradle wrapper
          --          }),
          require("neotest-vim-test")({
            ignore_file_types = { "python", "vim", "lua" },
          }),
        },
      })
    end,
  },
}
