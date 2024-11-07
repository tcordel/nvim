-- local filetypes = {
-- 	"javascript",
-- 	"javascriptreact",
-- 	"javascript.jsx",
-- 	"typescript",
-- 	"typescriptreact",
-- 	"typescript.tsx",
-- 	"java",
-- }
return {
	{
		"schrieveslaach/sonarlint",
		url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					table.insert(opts.ensure_installed, "sonarlint-language-server")
				end,
			},
			-- {
			-- 	"neovim/nvim-lspconfig"
			-- }
		},
		-- ft = filetypes,
		-- opts = {
		-- 	server = {
		-- 		cmd = {
		-- 			"sonarlint-language-server",
		-- 			"-stdio",
		-- 			"-analyzers",
		-- 			vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
		-- 			vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
		-- 		},
		-- 	},
		-- 	filetypes = filetypes,
		-- },
	},
}
