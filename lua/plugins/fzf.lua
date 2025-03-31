return {
	"ibhagwan/fzf-lua",
	opts = function(_, opts)
		local file_win_opts = {
			fullscreen = true,
			preview = {
				layout = "vertical",
				vertical = "up:70%",
			},
		}
		return {
			fzf_opts = {
				["--no-scrollbar"] = false,
			},
			winopts = file_win_opts,
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
			"<leader>ca",
			function()
				require("fzf-lua").lsp_code_actions()
			end,
			desc = "lsp_code_actions",
		},
		{
			"<leader>fs",
			function()
				require("fzf-lua").lsp_workspace_symbols()
			end,
			desc = "Search symbol",
		},
	},
}
