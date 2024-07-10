return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",        -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					show_hidden_count = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
			},
			buffers = { follow_current_file = { enable = true } },
			window = {
				mappings = {
					["U"] = function(state)
						local node = state.tree:get_node()
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end,
					['Y'] = function(state)
						-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
						-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
						local node = state.tree:get_node()
						local filepath = node:get_id()
						local filename = node.name
						local modify = vim.fn.fnamemodify

						local results = {
							filepath,
						modify(filepath, ':.'),
						modify(filepath, ':~'),
							filename,
						modify(filename, ':r'),
						modify(filename, ':e'),
						}
						local choices = {
							'1. Absolute path: ' .. results[1],
							'2. Path relative to CWD: ' .. results[2],
							'3. Path relative to HOME: ' .. results[3],
							'4. Filename: ' .. results[4],
							'5. Filename without extension: ' .. results[5],
							'6. Extension of the filename: ' .. results[6],
						}
						local resourceIndex = string.find(results[2], "resources/")
						if (resourceIndex) then
							local resourceFile = string.sub(results[2],resourceIndex + 10)
							table.insert(results, resourceFile)
							table.insert(choices, '7. resourceFile: '.. results[7])
						end
						vim.ui.select(choices, { prompt = 'Choose to copy to clipboard:' }, function(choice)
							if (choice) then
								local i = tonumber(choice:sub(1, 1))
								local result = results[i]
								vim.fn.setreg('+', result)
								vim.notify('Copied: ' .. result)
							end
						end)
					end
				},
			},
		})
	end
}
