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
			"JavaHello/spring-boot.nvim",
		},
		-- enabled = false,
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

		opts = function(_, opts)
			-- 	-- opts.root_dir = function(bufname)
			-- 	-- 	vim.notify("Entry", vim.log.levels.INFO)
			-- 	--   local path = require("jdtls.path")
			-- 	--   local dirname = vim.fn.fnamemodify(bufname, ":p:h")
			-- 	--   local getparent = function(p)
			-- 	--     return vim.fn.fnamemodify(p, ":h")
			-- 	--   end
			-- 	--   local pom = nil
			-- 	--   while getparent(dirname) ~= dirname do
			-- 	--     if vim.loop.fs_stat(path.join(dirname, "JenkinsFile")) then
			-- 	--       return dirname
			-- 	--     end
			-- 	--
			-- 	--     if vim.loop.fs_stat(path.join(dirname, "pom.xml")) then
			-- 	--       pom = dirname
			-- 	--     elseif pom ~= nil then
			-- 	--       return pom
			-- 	--     end
			-- 	--     dirname = getparent(dirname)
			-- 	--   end
			-- 	-- 	vim.notify(dirname, vim.log.levels.INFO)
			-- 	--   return dirname
			-- 	-- end
			-- 	opts.cmd = {
			-- 		vim.fn.exepath("jdtls"),
			-- 		"--jvm-arg=-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
			-- 		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			-- 		"-Dosgi.bundles.defaultStartLevel=4",
			-- 		"-Declipse.product=org.eclipse.jdt.ls.core.product",
			-- 		'-Dlog.protocol=true',
			-- 		'-Dlog.level=ALL',
			-- 		-- "jdt.core.sharedIndexLocation=/home/tcordel/.cache/.jdt/index",
			-- 		"-Xmx8g",
			-- 		"--add-modules=ALL-SYSTEM",
			-- 		"--add-opens",
			-- 		"java.base/java.util=ALL-UNNAMED",
			-- 		"--add-opens",
			-- 		"java.base/java.lang=ALL-UNNAMED",
			-- 	}
			opts.dap_main = false
			opts.settings = {
				java = {
					-- 			-- home = "/home/share/jdk-25+36",
					eclipse = {
						downloadSources = true,
					},
					maven = {
						downloadSources = true,
						updateSnapshots = false,
					},
					implementationsCodeLens = {
						enabled = true,
					},
					import = {
						maven = {
							offline = false,
						},
					},
					referencesCodeLens = {
						enabled = true,
					},
					references = {
						includeAccessors = true,
						includeDecompiledSources = true,
					},
					signatureHelp = {
						enabled = true,
					},
					autobuild = {
						enabled = true,
					},
					maxConcurrentBuilds = 4,
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
							"#",
						},
					},
					-- format = {
					-- 	enabled = true,
					-- 	settings = {
					-- 		url = os.getenv("HOME") .. ".config/nvim/resources/eno_code_formatter_java.xml",
					-- 		profile = "eno_code_formatter_java",
					-- 	},
					-- },
				},
			}
			--
			opts.jdtls = function(config)
				if vim.g.ci_enabled then
					vim.list_extend(config.init_options.bundles, require("spring_boot").java_extensions())
				end
				return config
			end
			return opts
		end,
	},
}
