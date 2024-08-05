return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		lang_to_formatters = {
			json = { "jq" },
			xml = { "xmlfomat" },
		},
		formatters_by_ft = {
			lua = { "stylua" },
			markdown = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			xml = { "xmlfomatter" },
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.format({ async = true, lsp_fallback = true })"
	end,
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	}
}
