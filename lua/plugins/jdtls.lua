vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "jdtls" then
			local wk = require("which-key")
			wk.add({
				{ "<leader>cm", group = "+maven" },
			})
		end
	end,
})
return {
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"folke/which-key.nvim",
			"mason-org/mason.nvim",
			"JavaHello/spring-boot.nvim",
		},
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
				"<leader>cmu",
				function()
					require("jdtls").update_project_config()
				end,
				ft = "java",
				desc = "Updage maven config",
			},
			{
				"<leader>cmb",
				function()
					require("jdtls").build_projects({ select_mode = "prompt" })
				end,
				ft = "java",
				desc = "Build project",
			},
		},

		ft = { "java" },
		opts = function(_, opts)
			-- opts.root_dir = function(bufname)
			-- 	vim.notify("Entry", vim.log.levels.INFO)
			--   local path = require("jdtls.path")
			--   local dirname = vim.fn.fnamemodify(bufname, ":p:h")
			--   local getparent = function(p)
			--     return vim.fn.fnamemodify(p, ":h")
			--   end
			--   local pom = nil
			--   while getparent(dirname) ~= dirname do
			--     if vim.loop.fs_stat(path.join(dirname, "JenkinsFile")) then
			--       return dirname
			--     end
			--
			--     if vim.loop.fs_stat(path.join(dirname, "pom.xml")) then
			--       pom = dirname
			--     elseif pom ~= nil then
			--       return pom
			--     end
			--     dirname = getparent(dirname)
			--   end
			-- 	vim.notify(dirname, vim.log.levels.INFO)
			--   return dirname
			-- end
			opts.cmd = {
				vim.fn.exepath("jdtls"),
				"--jvm-arg=-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				-- '-Dlog.protocol=true',
				-- '-Dlog.level=ALL',
				"-Xmx8g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
			}
			opts.settings = {
				java = {
					eclipse = {
						downloadSources = true,
					},
					maven = {
						downloadSources = true,
						updateSnapshots = false
					},
					implementationsCodeLens = {
						enabled = true,
					},
					import = {
						maven = {
							offline = true
						}

					},
					referencesCodeLens = {
						enabled = true,
					},
					references = {
						includeDecompiledSources = true,
					},
					-- autobuild = {
					-- 	enabled = false,
					-- },
					completion = {
						favoriteStaticMembers = {
							"java.util.*",
							"java.util.Collections.*",
							"java.util.List.*",
							"java.util.Map.*",
							"java.util.stream.*",
							"java.util.stream.Stream.*",
							"java.lang.*",
							"org.apache.commons.lang3.StringUtils.*",
							"org.springframework.http.MediaType.*",
							"org.assertj.core.api.Assertions.*",
							"java.util.Objects.requireNonNull",
							"java.util.Objects.requireNonNullElse",
							"org.mockito.Mockito.*",
							"org.mockito.ArgumentMatchers.*",
							"org.mockito.Answers.RETURNS_DEEP_STUBS",
						},
						filteredTypes = {
							"com.sun.*",
							"io.micrometer.shaded.*",
							"java.awt.*",
							"jdk.*",
							"sun.*",
						},
						importOrder = {
							"java",
							"javax",
							"org.apache",
							"org.springframework",
							"org",
							"com",
							"",
							"#"
						},
					},
					format = {
						enabled = true,
						settings = {
							url = os.getenv("HOME") .. ".config/nvim/resources/eno_code_formatter_java.xml",
							profile = "eno_code_formatter_java",
						},
					},
				},
			}

			opts.jdtls = function(config)
				config.handlers = {
					["language/status"] = function(_, result)
						-- print(result)
					end,
					["$/progress"] = function(_, result, ctx)
						-- disable progress updates.
					end,
				}


				local ls_path = vim.fn.expand("$MASON/packages/spring-boot-tools/extension/language-server/spring-boot-language-server-*.jar")

				if vim.g.ci_enabled then
					require("spring_boot").setup({
						jdtls_name = "jdtls",
						exploded_ls_jar_data = false,
						server = {
							cmd = {
								"java",
								"-XX:TieredStopAtLevel=1",
								"-Xmx4G",
								"-XX:+UseZGC",
								"-Dsts.lsp.client=vscode",
								"-Dsts.log.file=" .. os.getenv("HOME") .. "/.local/state/nvim/spring-boot.log",
								"-jar",
								ls_path,
							},
						},
					})
					require("spring_boot").init_lsp_commands()
					vim.list_extend(config.init_options.bundles, require("spring_boot").java_extensions())
				end
				return config
			end
			return opts
		end,
	},
}
