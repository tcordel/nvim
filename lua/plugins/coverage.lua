local wk = require("which-key")
wk.add({
	{ "<leader>t", group = "+test" },
})
wk.add({
	{ "<leader>tc", group = "+coverage" },
})
return {
	"andythigpen/nvim-coverage",
	version = "*",
	keys = {
		{
			"<leader>tcl",
			"<Cmd>Coverage<CR>",
			desc = "Load",
		},
		{
			"<leader>tcc",
			"<Cmd>CoverageClear<CR>",
			desc = "clear",
		},
		{
			"<leader>tco",
			"<Cmd>CoverageToggle<CR>",
			desc = "Toggle coverage",
		},
		{
			"<leader>tcs",
			"<Cmd>CoverageSummary<CR>",
			desc = "Summary",
		},
	},
	config = function()
		require("coverage").setup({
			commands = true, -- create commands
			highlights = {
				-- customize highlight groups created by the plugin
				covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
				uncovered = { fg = "#F07178" },
			},
			signs = {
				-- use your own highlight groups or text markers
				covered = { hl = "CoverageCovered", text = "▎" },
				uncovered = { hl = "CoverageUncovered", text = "▎" },
			},
			summary = {
				-- customize the summary pop-up
				min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
			},
			lang = {
				java = {
					dir_prefix = "src/main/java",
					coverage_file = vim.fn.getcwd() .. "/target/site/jacoco/jacoco.xml",
				},
			},
		})
	end,
}
