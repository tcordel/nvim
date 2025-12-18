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
			"tcordel/neo-tree-maven-dependencies.nvim",
		},
		enabled = vim.g.lsp_enabled,
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

			{
				"<leader>cmd",
				"<Cmd>Neotree maven toggle<CR>",
				ft = "java",
				desc = "Show project [d]ependencies",
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
			-- opts.cmd = {
			-- 	vim.fn.exepath("jdtls"),
			-- 	"--jvm-arg=-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
			-- 	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			-- 	"-Dosgi.bundles.defaultStartLevel=4",
			-- 	"-Declipse.product=org.eclipse.jdt.ls.core.product",
			-- 	"-Dlog.protocol=true",
			-- 	"-Dlog.level=ALL",
			-- 	"-Xmx8g",
			-- 	"-XX:+EnableDynamicAgentLoading",
			-- 	"--add-modules=ALL-SYSTEM",
			-- 	"--add-opens",
			-- 	"java.base/java.util=ALL-UNNAMED",
			-- 	"--add-opens",
			-- 	"java.base/java.lang=ALL-UNNAMED",
			-- 	"--add-opens",
			-- 	"java.xml/com.sun.org.apache.xml.internal.serialize=ALL-UNNAMED",
			-- }
			opts.dap_main = false
			opts.settings = {
				java = {
					home = "/home/share/jdk-25+36",
					eclipse = {
						downloadSources = true,
					},
					maven = {
						downloadSources = true,
						updateSnapshots = false,
					},
					-- implementationsCodeLens = {
					-- 	enabled = true,
					-- },
					import = {
						maven = {
							offline = false,
						},
					},
					referencesCodeLens = {
						enabled = false,
					},
					references = {
						includeAccessors = true,
						includeDecompiledSources = true,
					},
					signatureHelp = {
						enabled = false,
					},
					autobuild = {
						enabled = true,
					},
					-- maxConcurrentBuilds = 4,
					completion = {
						favoriteStaticMembers = {
							"com.github.tomakehurst.wiremock.client.WireMock.*",
							"com.github.tomakehurst.wiremock.matching.MatchResult.*",
							"java.lang.*",
							"java.lang.Integer.*",
							"java.lang.String.*",
							"java.lang.System.*",
							"java.nio.charset.Charset.*",
							"java.nio.charset.StandardCharsets.*",
							"java.nio.file.Files.*",
							"java.util.*",
							"java.util.Calendar.*",
							"java.util.Collections.*",
							"java.util.EnumSet.*",
							"java.util.List.*",
							"java.util.Map.*",
							"java.util.Objects.*",
							"java.util.Optional.*",
							"java.util.function.Function.*",
							"java.util.stream.*",
							"java.util.stream.Collectors.*",
							"java.util.stream.Stream.*",
							"org.apache.commons.lang3.StringUtils.*",
							"org.assertj.core.api.Assertions.*",
							"org.hibernate.jpa.HibernateHints.*",
							"org.junit.jupiter.api.Assertions.*",
							"org.junit.jupiter.api.DynamicTest.*",
							"org.junit.jupiter.api.TestInstance.Lifecycle.*",
							"org.junit.jupiter.params.ParameterizedTest.*",
							"org.junit.jupiter.params.provider.Arguments.*",
							"org.mapstruct.MappingConstants.ComponentModel.*",
							"org.mapstruct.ReportingPolicy.*",
							"org.mockito.AdditionalMatchers.*",
							"org.mockito.Answers.*",
							"org.mockito.ArgumentMatchers.*",
							"org.mockito.Mockito.*",
							"org.mockito.MockitoAnnotations.*",
							"org.mockito.internal.verification.VerificationModeFactory.*",
							"org.springframework.beans.factory.config.ConfigurableBeanFactory.*",
							"org.springframework.boot.test.context.SpringBootTest.WebEnvironment.*",
							"org.springframework.cloud.gateway.server.mvc.filter.BeforeFilterFunctions.*",
							"org.springframework.cloud.gateway.server.mvc.handler.HandlerFunctions.*",
							"org.springframework.context.annotation.FilterType.*",
							"org.springframework.core.annotation.AnnotatedElementUtils.*",
							"org.springframework.http.HttpHeaders.*",
							"org.springframework.http.HttpMethod.*",
							"org.springframework.http.MediaType.*",
							"org.springframework.http.ResponseEntity.*",
							"org.springframework.security.config.Customizer.*",
							"org.springframework.security.config.http.SessionCreationPolicy.*",
							"org.springframework.security.oauth2.core.oidc.StandardClaimNames.*",
							"org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.*",
							"org.springframework.security.web.servlet.util.matcher.PathPatternRequestMatcher.*",
							"org.springframework.test.annotation.DirtiesContext.ClassMode.*",
							"org.springframework.test.web.servlet.client.MockMvcWebTestClient.*",
							"org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
							"org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
							"org.springframework.web.bind.annotation.RequestMethod.*",
							"org.springframework.web.context.request.RequestAttributes.*",
							"org.springframework.web.servlet.function.RequestPredicates.*",
							"org.springframework.web.servlet.function.RouterFunctions.*",
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
