return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "schrieveslaach/sonarlint",
        url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
        dependencies = {
          {
            "williamboman/mason.nvim",
            opts = function(_, opts)
              opts.ensure_installed = opts.ensure_installed or {}
              table.insert(opts.ensure_installed, "sonarlint-language-server")
            end,
          },
        },
      },
    },
    opts = {
      -- make sure mason installs the server
      servers = {
        jdtls = {},
      },
      setup = {
        jdtls = function()
          require("sonarlint").setup({
            server = {
              cmd = {
                "sonarlint-language-server",
                -- Ensure that sonarlint-language-server uses stdio channel
                "-stdio",
                "-analyzers",
                -- paths to the analyzers you need, using those for python and java in this example
                vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
                vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
                vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
              },
            },
            filetypes = {
              -- Tested and working
              "python",
              "cpp",
              "java",
            },
          })
          return true -- avoid duplicate servers
        end,
      },
    },
  },
}
