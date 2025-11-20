return {
	"nvim-neo-tree/neo-tree.nvim",
	-- branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		"sindrets/diffview.nvim",
		"tcordel/neo-tree-maven-dependencies.nvim",
	},
	opts = function(_, opts)
		table.insert(opts.sources, "maven")

		opts.filesystem.group_dirs_and_files = true -- when true, empty folders and files will be grouped together
		opts.filesystem.group_empty_dirs = true -- when true, empty directories will be grouped together
		opts.window.mappings = vim.tbl_extend("force", opts.window.mappings, {
			["U"] = {
				function(state)
					local node = state.tree:get_node()
					require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
				end,
				desc = "Go to parent node",
			},
			["Y"] = {
				function(state)
					-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
					-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local results = {
						filepath,
						modify(filepath, ":."),
						modify(filepath, ":~"),
						filename,
						modify(filename, ":r"),
						modify(filename, ":e"),
					}
					local choices = {
						"1. Absolute path: " .. results[1],
						"2. Path relative to CWD: " .. results[2],
						"3. Path relative to HOME: " .. results[3],
						"4. Filename: " .. results[4],
						"5. Filename without extension: " .. results[5],
						"6. Extension of the filename: " .. results[6],
					}

					local resourceIndex = string.find(results[2], "resources/")
					local index = 7
					if resourceIndex then
						local resourceFile = string.sub(results[2], resourceIndex + 10)
						table.insert(results, resourceFile)
						table.insert(choices, index .. ". resourceFile: " .. results[index])
						index = index + 1
					end
					if string.match(results[1], ".java$") then
						local f = io.open(results[1], "r")
						if f then
							local packageDeclaration = f:read()
							if string.match(packageDeclaration, "^package ") then
								local length = string.len(packageDeclaration)
								local packagePath = string.sub(packageDeclaration, 9, length - 1)
								local qualifiedName = packagePath .. "." .. results[5]
								table.insert(results, qualifiedName)
								table.insert(choices, index .. ". qualifiedName: " .. results[index])
								index = index + 1
							end
							f:close()
						end
					end
					vim.ui.select(choices, { prompt = "Choose to copy to clipboard:" }, function(choice)
						if choice then
							local i = tonumber(choice:sub(1, 1))
							local result = results[i]
							vim.fn.setreg("+", result)
							vim.notify("Copied: " .. result)
						end
					end)
				end,
				desc = "Yank file...",
			},
		})
		opts.maven = {
			window = {
				mappings = {
					["I"] = "invalidate",
				},
			},
			group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
			group_empty_dirs = true, -- when true, empty directories will be grouped together
			renderers = {
				directory = {
					{ "indent" },
					{ "icon" },
					{ "name" },
				},
				file = {
					{ "indent" },
					{ "icon" },
					{ "name" },
				},
			},
		}
	end,
}
