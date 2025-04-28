local filetypes = {
	"javascript",
	"javascriptreact",
	"javascript.jsx",
	"typescript",
	"typescriptreact",
	"typescript.tsx",
	"java",
}
local ci = os.getenv("NO_CI")
local enabled = ci == nil or ci ~= "true"
return {
	"schrieveslaach/sonarlint",
	url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
	dependencies = {
		{
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	enabled = enabled,
	config = function()
		require("sonarlint").setup({
			server = {
				cmd = {
					"sonarlint-language-server",
					"-stdio",
					"-analyzers",
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
				},
			},
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"java",
			},
		})
	end,
	ft = filetypes,
}
