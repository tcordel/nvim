vim.diagnostic.config({ update_in_insert = false })
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
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
				},
			},
		},
		opts = {
			--
			-- make sure mason installs the server
			servers = {
				jdtls = {},
				vtsls = {},
			},
			setup = {
				jdtls = function()
					-- require("sonarlint").setup({
					--   server = {
					--     cmd = {
					--       "sonarlint-language-server",
					--       "-stdio",
					--       "-analyzers",
					--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
					--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
					--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
					--     },
					--   },
					--   filetypes = {
					--     -- Tested and working
					--     "python",
					--     "cpp",
					--     "java",
					--   },
					-- })
					return true -- avoid duplicate servers
				end,
				vtsls = function()
					-- require("sonarlint").setup({
					--   server = {
					--     cmd = {
					--       "sonarlint-language-server",
					--       "-stdio",
					--       "-analyzers",
					--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
					--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
					--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
					--     },
					--   },
					--   filetypes = {
					--     "javascript",
					--     "javascriptreact",
					--     "javascript.jsx",
					--     "typescript",
					--     "typescriptreact",
					--     "typescript.tsx",
					--   },
					-- })
				end,
			},
		},
	},
}
