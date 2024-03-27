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
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mfussenegger/nvim-jdtls" },
    -- keys = {
    -- {
    --   "<leader>dr",
    --   function()
    -- 	require('dap').adapters.java = function(callback)
    -- 	callback({
    -- 		type = 'server';
    -- 		host = '127.0.0.1';
    -- 		port = 2000;
    -- 	})
    --   end,
    --   desc = "Debug remote",
    -- },
    -- 	},
    opts = {
      setup = {
        jdtls = function(_, opts)
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
              require("lazyvim.util").lsp.on_attach(function(_, buffer)
                --                vim.keymap.set(
                --                  "n",
                --                  "<leader>cxi",
                --                  "<Cmd>lua require'jdtls'.organize_imports()<CR>",
                --                  { buffer = buffer, desc = "Organize Imports" }
                --                )
                --                vim.keymap.set(
                --                  "v",
                --                  "<leader>de",
                --                  "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
                --                  { buffer = buffer, desc = "Extract Variable" }
                --                )
                --                vim.keymap.set(
                --                  "n",
                --                  "<leader>de",
                --                  "<Cmd>lua require('jdtls').extract_variable()<CR>",
                --                  { buffer = buffer, desc = "Extract Variable" }
                --                )
                --                vim.keymap.set(
                --                  "v",
                --                  "<leader>dm",
                --                  "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
                --                  { buffer = buffer, desc = "Extract Method" }
                --                )
                --                vim.keymap.set(
                --                  "n",
                --                  "<leader>cf",
                --                  "<cmd>lua vim.lsp.buf.formatting()<CR>",
                --                  { buffer = buffer, desc = "Format" }
                --                )
              end)
            end,
          })
        end,
      },
    },
  },
}
