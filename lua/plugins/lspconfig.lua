vim.diagnostic.config({ update_in_insert = false })
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			inlay_hints = { enabled = false },
			--
			-- make sure mason installs the server
			servers = {
				jdtls = { enabled = false },
				vtsls = {},
				powershell_es = {},
				bashls = {},
				lua_ls = {},
				groovyls = {},
				lemminx = {},
			},
			setup = {
				jdtls = function()
					return true -- avoid duplicate servers
				end,
			},
		},
	},
}
