local filetypes = {
	"javascript",
	"javascriptreact",
	"javascript.jsx",
	"typescript",
	"typescriptreact",
	"typescript.tsx",
	"java",
}
return {
	"schrieveslaach/sonarlint",
	url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
	dependencies = {
		{
			"mason-org/mason.nvim",

			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "sonarlint-language-server")
			end,
		},
		"neovim/nvim-lspconfig",
	},
	enabled = vim.g.ci_enabled,
	config = function()
		require("sonarlint").setup({
			server = {
				cmd = {
					"sonarlint-language-server",
					"-stdio",
					"-analyzers",
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjavasymbolicexecution.jar"),
				},
				settings = {
					sonarlint = {
						rules = {
							["typescript:S6440"] = { level = "off" },
						},
					},
				},
			},
			filetypes = filetypes,
		})
	end,
	ft = filetypes,
}
