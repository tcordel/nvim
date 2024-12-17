return {
	"ibhagwan/fzf-lua",
	opts = function(_, opts)
		return {
			fzf_opts = {
				["--no-scrollbar"] = false,
			},
		}
	end,
	keys = {
		{
			"gh",
			function()
				require("fzf-lua").lsp_incoming_calls()
			end,
			desc = "lsp_incoming_calls",
		},
		{
			"<leader>fs",
			function()
				require("fzf-lua").lsp_dynamic_workspace_symbols({
					query = "",
					sorting_strategy = "ascending",
				})
			end,
			desc = "Search symbol",
		},
	},
}
