return {
	{
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
			-- dap.adapters["pwa-chrome"] = {
			-- 	type = "server",
			-- 	host = "localhost",
			-- 	port = "${port}",
			-- 	executable = {
			-- 		command = "node",
			-- 		args = {
			-- 			vim.fn.expand("$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"),
			-- 			-- get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
			-- 			"${port}",
			-- 		},
			-- 	},
			-- }
			-- for _, lang in ipairs({
			-- 	"typescript",
			-- 	"javascript",
			-- 	"typescriptreact",
			-- 	"javascriptreact",
			-- }) do
			-- 	dap.configurations[lang] = dap.configurations[lang] or {}
			-- 	table.insert(dap.configurations[lang], {
			-- 		name = "Chrome: EIE",
			-- 		type = "chrome",
			-- 		request = "attach",
			-- 		program = "${file}",
			-- 		cwd = vim.fn.getcwd(),
			-- 		sourceMaps = true,
			-- 		protocol = "inspector",
			-- 		port = 9222,
			-- 		webRoot = "${workspaceFolder}",
			-- 		urlFilter="http://localhost:5173/*",
			-- 	})
			-- end
			dap.configurations.java = {
				{
					name = "Java - Remote",
					type = "java",
					request = "attach",
					hostName = "127.0.0.1",
					-- hostName = "172.22.0.1",

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
	},
	{
		"lucaSartore/nvim-dap-exception-breakpoints",
		dependencies = { "mfussenegger/nvim-dap" },

		config = function()
			local set_exception_breakpoints = require("nvim-dap-exception-breakpoints")

			vim.api.nvim_set_keymap(
				"n",
				"<leader>dE",
				"",
				{ desc = "[D]ebug [E]xception breakpoints", callback = set_exception_breakpoints }
			)
		end,
	},
}
