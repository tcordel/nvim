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
      opts.root_dir = function(bufname)
        local path = require("jdtls.path")
        local dirname = vim.fn.fnamemodify(bufname, ":p:h")
        local getparent = function(p)
          return vim.fn.fnamemodify(p, ":h")
        end
        local pom = nil
        while getparent(dirname) ~= dirname do
          if vim.loop.fs_stat(path.join(dirname, "JenkinsFile")) then
            return dirname
          end

          if vim.loop.fs_stat(path.join(dirname, "pom.xml")) then
            pom = dirname
          elseif pom ~= nil then
            return pom
          end
          dirname = getparent(dirname)
        end

        vim.notify(dirname)
        return dirname
      end
      opts.cmd = {
        vim.fn.exepath("jdtls"),
        "--jvm-arg=-javaagent:" .. require("mason-registry").get_package("jdtls"):get_install_path() .. "/lombok.jar",
      }
    end,
  },
}
