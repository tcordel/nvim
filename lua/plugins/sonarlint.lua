local filetypes = {
	"javascript",
	"javascriptreact",
	"javascript.jsx",
	"typescript",
	"typescriptreact",
	"typescript.tsx",
	"java",
}
return {
	"schrieveslaach/sonarlint",
	url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
	dependencies = {
		{
			"mason-org/mason.nvim",

			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "sonarlint-language-server")
			end,
		},
		"neovim/nvim-lspconfig",
	},
	enabled = vim.g.ci_enabled,
	config = function()
		-- Analyse uniquement à la sauvegarde pour éviter les freezes sur les
		-- gros projets Java. Sans ça, chaque frappe envoie un
		-- textDocument/didChange que sonarjava + symbolic-execution ré-analysent
		-- en entier. On intercepte au niveau de client.notify pour shunter la
		-- notification avant qu'elle n'atteigne le serveur, peu importe ce que
		-- _changetracking a caché côté nvim.
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client or not client.name:match("sonarlint") then
					return
				end
				client.server_capabilities.textDocumentSync = {
					openClose = true,
					change = 0, -- None
					save = { includeText = true },
				}
				if not client.__didchange_patched then
					client.__didchange_patched = true
					local original_notify = client.notify
					client.notify = function(...)
						local a, b = ...
						if a == "textDocument/didChange" or b == "textDocument/didChange" then
							return true
						end
						return original_notify(...)
					end
				end
			end,
		})

		require("sonarlint").setup({
			server = {
				cmd = {
					"sonarlint-language-server",
					"-stdio",
					"-analyzers",
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjavasymbolicexecution.jar"),
				},
				settings = {
					sonarlint = {
						rules = {
							["typescript:S6440"] = { level = "off" },
							["java:S112"] = { level = "off" }, -- Generic exception
							["java:S3252"] = { level = "off" }, -- Prefer static import
							["java:S3776"] = { level = "off" }, -- Complexity
							["java:S6541"] = { level = "off" }, -- Brain method
						},
					},
				},
			},
			filetypes = filetypes,
		})
	end,
	ft = filetypes,
}
