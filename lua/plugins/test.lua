local searchFirstPackageJsonInParentFolder = function(bufname)
	local dirname = vim.fn.fnamemodify(bufname, ":p:h")
	local getparent = function(p)
		return vim.fn.fnamemodify(p, ":h")
	end
	while getparent(dirname) ~= dirname do
		if vim.loop.fs_stat(dirname .. package.config:sub(1, 1) .. "package.json") then
			return dirname
		end
		dirname = getparent(dirname)
	end
	return vim.fn.getcwd()
end

local getcwd = function()
	local bufname = vim.fn.expand("%:p")
	return searchFirstPackageJsonInParentFolder(bufname)
end
return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
		},
		requires = {
			"nvim-neotest/neotest-jest",
		},
		keys = {
			{
				"<leader>tt",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run File",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "Debug Nearest",
			},
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "Run Nearest",
			},
			{
				"<leader>tl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Run Last",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle Summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "Show Output",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle Output Panel",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop",
			},
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
                        jestCommand = "yarn test --",
						-- jestConfigFile = function()
						-- 	local cwd = getcwd()
						-- 	local jest_config_path = cwd .. package.config:sub(1, 1) .. "package.json"
						--
						-- 	local package_json_path = cwd .. package.config:sub(1, 1) .. "package.json"
						-- 	local package_json_content = vim.fn.readfile(package_json_path)
						--
						-- 	-- Check if the file read is successful
						-- 	if next(package_json_content) == nil then
						-- 		vim.notify("package.json is empty or does not exist")
						-- 		return nil
						-- 	end
						--
						-- 	package_json_content = table.concat(package_json_content, "")
						-- 	local decoded_json = vim.fn.json_decode(package_json_content)
						--
						-- 	-- Check if scripts exists and specifically test script
						-- 	vim.notify(decoded_json)
						-- 	if decoded_json and decoded_json.scripts and decoded_json.scripts.test then
						-- 		local test_script = decoded_json.scripts.test
						--
						-- 		-- Pattern to match the --config argument
						-- 		local config_arg_pattern = "%-%-config%s([%w%./_-]+)"
						-- 		local config_path = test_script:match(config_arg_pattern)
						-- 		vim.notify("Config found" .. config_path)
						--
						-- 		return config_path
						-- 	else
						-- 		vim.notify("No test script found in package.json")
						-- 		return cwd .. "jest.config.ts"
						-- 	end
						-- end,
						env = { CI = true },
						cwd = getcwd,
					}),
				},
			})
		end,
	},
}
