return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			markdown = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			xml = { "tidy" },
			json = {"jq"}
		},
		formatters = {
			injected = { options = { ignore_errors = true } },
			tidy = {
				command = "tidy",
				args = {
					"-q",
					"--input-xml",
					"true",
					"--indent",
					"yes",
					"--indent-attributes",
					"1",
					"--indent-spaces",
					"4",
					"--vertical-space",
					"true",
					"--wrap",
					"0",
				},
				stdin = true,
			},
		},
		default_format_opts = {
			lsp_format = "prefer",
			quiet = true,
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
				local ignore_filetypes = { "lua" }
				if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
					require("conform").format({ async = true, lsp_fallback = true })
					return
				end

				local hunks = require("gitsigns").get_hunks(0)
				if hunks == nil then
					return
				end

				local format = require("conform").format

				local function format_range()
					if next(hunks) == nil then
						vim.notify("done formatting git hunks", "info", { title = "formatting" })
						return
					end
					local hunk = nil
					while next(hunks) ~= nil and (hunk == nil or hunk.type == "delete") do
						hunk = table.remove(hunks)
					end

					if hunk ~= nil and hunk.type ~= "delete" then
						local start = hunk.added.start
						local last = start + hunk.added.count
						-- nvim_buf_get_lines uses zero-based indexing -> subtract from last
						local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
						local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
						format({ range = range, async = true, lsp_fallback = true }, function()
							vim.defer_fn(function()
								format_range()
							end, 1)
						end)
					end
				end

				format_range()
			end,
			mode = "",
			desc = "Format buffer hunks",
		},
		{
			"<leader>cF",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format Full buffer",
		},
	},
}
