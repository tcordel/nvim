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

-- -- désactive les diagnostics en mode insertion
-- vim.api.nvim_create_autocmd("InsertEnter", {
-- 	callback = function(event)
-- 		vim.notify("Stopping diagnostics")
-- 		pcall(vim.diagnostic.disable, event.buf)
-- 	end,
-- })
--
-- -- réactive à la sortie du mode insertion
-- vim.api.nvim_create_autocmd("InsertLeave", {
-- 	callback = function(event)
-- 		vim.notify("Enabling diagnostics")
-- 		pcall(vim.diagnostic.enable, false, { bufnr = event.buf })
-- 	end,
-- })
