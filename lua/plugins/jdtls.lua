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
      {
        "<leader>cm",
        function()
          require("jdtls").update_project_config()
        end,
        ft = "java",
        desc = "Updage maven config",
      },
      {
        "<leader>cf",
        function()
          vim.lsp.buf.format()
        end,
        ft = "java",
        desc = "Format LSP",
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
        return dirname
      end
      opts.cmd = {
        vim.fn.exepath("jdtls"),
        "--jvm-arg=-javaagent:" .. require("mason-registry").get_package("jdtls"):get_install_path() .. "/lombok.jar",
      }
      opts.jdtls = {
        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            maven = {
              downloadSources = true,
            },
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            completion = {
              favoriteStaticMembers = {
                "org.assertj.core.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.mockito.Answers.RETURNS_DEEP_STUBS",
              },
            },
            format = {
              enabled = true,
              settings = {
                url = os.getenv("HOME") .. ".config/nvim/resources/eno_code_formatte_java.xml",
                profile = "eno_code_formatter_java",
              },
            },
          },
        },
        handlers = {
          ["language/status"] = function(_, result)
            -- print(result)
          end,
          ["$/progress"] = function(_, result, ctx)
            -- disable progress updates.
          end,
        },
      }
      return opts
    end,
  },
}
