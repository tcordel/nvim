return {
	"mfussenegger/nvim-dap",
	optional = true,
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "js-debug-adapter")
			end,
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
						local file = vim.fn.expand("%")
						local project = "eai-commun";
						for str in string.gmatch(file, "([^/]+)") do
							if str ~= "eai" then
								project = str
								break
							end
						end
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
		if not dap.adapters["pwa-node"] then
			require("dap").adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						require("mason-registry").get_package("js-debug-adapter"):get_install_path()
						.. "/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}
		end
		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			if not dap.configurations[language] then
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end
	end,
}
