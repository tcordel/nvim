return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "js-debug-adapter")
        table.insert(opts.ensure_installed, "firefox-debug-adapter")
        table.insert(opts.ensure_installed, "chrome-debug-adapter")
      end,
    },
  },
  opts = function()
    local dap = require("dap")
    dap.configurations.java = {
      {
        name = "Java - Remote",
        type = "java",
        request = "attach",
        hostName = "127.0.0.1",
        port = "2000",
      },
    }
    dap.adapters.chrome = {
      type = "executable",
      command = "node",
      args = {
        require("mason-registry").get_package("chrome-debug-adapter"):get_install_path() .. "/out/src/chromeDebug.ts",
      }, -- TODO adjust
    }
    dap.adapters.firefox = {
      type = "executable",
      command = "node",
      args = {
        require("mason-registry").get_package("firefox-debug-adapter"):get_install_path() .. "/dist/adapter.bundle.js",
      },
    }

    --    dap.configurations.typescript = {
    --      {
    --        name = "Debug with Firefox",
    --        type = "firefox",
    --        request = "launch",
    --        reAttach = true,
    --        url = "http://localhost:3000",
    --        webRoot = "${workspaceFolder}",
    --        firefoxExecutable = "/snap/bin/firefox",
    --      },
    --    }
    dap.configurations.javascriptreact = { -- change this to javascript if needed
      {

        name = "Debug with Chrome",
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
      },
    }

    dap.configurations.javascript= { -- change this to javascript if needed
      {

        name = "Debug with Chrome",
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
      },
    }
    dap.configurations.typescriptreact = { -- change to typescript if needed
      {
        name = "Debug with Chrome",
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
      },
    }

    dap.configurations.typescript = { -- change to typescript if needed
      {
        name = "Debug with Chrome",
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
      },
    }
  end,
}
