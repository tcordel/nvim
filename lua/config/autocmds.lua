-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#51B3EC", bold = true })
vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.txt", "*.md", "*.MD" },
	callback = function()
		vim.opt.spell = true
	end,
})

vim.filetype.add({
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
		["*.bpml"] = "xml",
	},
})

local wk = require("which-key")
wk.add({
	{
		"<leader>cD",
		function()
			local buffer = vim.api.nvim_get_current_buf()
			local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
			local fzf = require("fzf-lua")
			return fzf.fzf_exec("find . -name '*.pom'", {
				prompt = "dependencies> ",
				cwd = "$HOME/.m2/repository/",
				actions = {
					["default"] = function(selected, opts)
						local pom = selected[1]
						local splitted = {}
						local size = 0
						for i in string.gmatch(pom, "([^/]+)") do
							table.insert(splitted, i)
							size = size + 1
						end
						local version = splitted[size - 1]
						local artifactId = splitted[size - 2]
						local groupId = ""
						for i = 2, (size - 2) do
							if i > 2 then
								groupId = groupId .. "."
							end
							groupId = groupId .. splitted[i]
						end

						local dependency = {
							"		<dependency>",
							"			<groupId>" .. groupId .. "</groupId>",
							"			<artifactId>" .. artifactId .. "</artifactId>",
							"			<version>" .. version .. "</version>",
							"		</dependency>",
						}
						vim.api.nvim_buf_set_lines(buffer, line, line, false, dependency)
					end,
				},
			})
		end,
	},

	{
		"gh",
		function()
			vim.lsp.buf.incoming_calls()
		end,
		desc = "incoming calls",
	},
	{
		"gl",
		function()
			vim.lsp.buf.outgoing_calls()
		end,
		desc = "outgoing calls",
	},
	{
		"gj",
		function()
			require("litee.calltree").expand_calltree()
		end,
		desc = "Expand calltree",
	},
})

vim.lsp.handlers["language/status"] = function(_, result)
	-- print(result)
end
-- vim.lsp.handlers["$/progress"] = function(_, result, ctx)
-- 	-- disable progress updates.
-- end
