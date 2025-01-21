local wk = require("which-key")
wk.add({ "<leader>gd", group = "diffview" }, { "<leader>gh", group = "hunks" })
return {
	"sindrets/diffview.nvim",
	keys = {
		{
			"<leader>gdl",
			"<Cmd>DiffviewFileHistory<CR>",
			desc = "Log",
		},
		{
			"<leader>gdL",
			"<Cmd>DiffviewFileHistory %<CR>",
			desc = "Log File",
		},
		{
			"<leader>gdo",
			"<Cmd>DiffviewOpen<CR>",
			desc = "diffview open",
		},
		{
			"<leader>gdc",
			"<Cmd>DiffviewClose<CR>",
			desc = "diffview close",
		},
		{
			"<leader>ghb",
			function()
				require("gitsigns").blame_line()
			end,
			desc = "Blame File",
		},
		{
			"<leader>ghB",
			function()
				require("gitsigns").blame()
			end,
			desc = "Blame File",
		},
		{
			"<leader>ghr",
			function()
				require("gitsigns").reset_hunk()
			end,
			desc = "reset hunk",
		},
		{
			"<leader>ghR",
			function()
				require("gitsigns").reset_buffer()
			end,
			desc = "reset buffer",
		},
	},
	opts = {

		view = {
			-- Configure the layout and behavior of different types of views.
			-- Available layouts:
			--  'diff1_plain'
			--    |'diff2_horizontal'
			--    |'diff2_vertical'
			--    |'diff3_horizontal'
			--    |'diff3_vertical'
			--    |'diff3_mixed'
			--    |'diff4_mixed'
			-- For more info, see |diffview-config-view.x.layout|.
			default = {
				-- Config for changed files, and staged files in diff views.
				layout = "diff2_horizontal",
				-- disable_diagnostics = true,
				winbar_info = true, -- See |diffview-config-view.x.winbar_info|
			},
			merge_tool = {
				-- Config for conflicted files in diff views during a merge or rebase.
				layout = "diff4_mixed",
			},
		},
		keymaps = {
			file_panel = {
				{
					"n",
					"<leader>gr",
					function()
						require("diffview.config").actions.restore_entry()
						-- local file = require("diffview.config").actions.file_panel.get_item_at_cursor()
						-- local cmd = { "git", "checkout", "HEAD", "--", file }

						-- vim.fn.system(cmd)
					end,
					{ desc = "reset diff" },
				},
			},
		},
	},
}
