return {
	{
		"rcarriga/nvim-dap-ui",
		keys = {
			{
				"<leader>duu",
				function()
					require("dapui").toggle()
				end,
				desc = "Toogle UI",
			},
			{
				"<leader>dub",
				function()
					require("dapui").float_element("breakpoints", {
						title = "breakpoints",
						width = 100,
						height = 40,
						position = "center",
						enter = true,
					})
				end,
				desc = "Float breakpoints",
			},
			{
				"<leader>dut",
				function()
					require("dapui").float_element("stacks", {
						title = "Threads",
						width = 1000,
						height = 80,
						position = "center",
						enter = true,
					})
				end,
				desc = "Float Threads",
			},
		},
		opts = {
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.75,
						},
						-- {
						-- 	id = "breakpoints",
						-- 	size = 0.25,
						-- },
						-- {
						-- 	id = "stacks",
						-- 	size = 0.25,
						-- },
						{
							id = "watches",
							size = 0.25,
						},
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 10,
				},
			},
		},
	},
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
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(
						vim.fn.input("condition> "),
						vim.fn.input("log condition> "),
						vim.fn.input("log> ")
					)
				end,
				desc = "Breakpoint Condition",
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
