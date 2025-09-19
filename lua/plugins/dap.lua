return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    {
      "mason-org/mason.nvim",
    },
  },
  keys = {
    {
      "<leader>dO",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
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

        projectName = function()
          local co = coroutine.running()
          return coroutine.create(function()
            local path = require("jdtls.path")
            local file = vim.fn.expand("%")
            local dirname = vim.fn.fnamemodify(file, ":p:h")
            local getparent = function(p)
              return vim.fn.fnamemodify(p, ":h")
            end

            while getparent(dirname) ~= dirname do
              if vim.loop.fs_stat(path.join(dirname, "pom.xml")) then
                break
              end
              dirname = getparent(dirname)
            end
            local project = vim.fn.fnamemodify(dirname, ":t")
            vim.ui.input({
              prompt = "ProjectName: ",
              default = project,
            }, function(projectName)
              if projectName == nil or projectName == "" then
                return
              else
                coroutine.resume(co, projectName)
              end
            end)
          end)
        end,
        port = function()
          local co = coroutine.running()
          return coroutine.create(function()
            vim.ui.input({
              prompt = "Enter Port: ",
              default = "2000",
            }, function(port)
              if port == nil or port == "" then
                return
              else
                coroutine.resume(co, port)
              end
            end)
          end)
        end,
      },
    }
  end,
}
