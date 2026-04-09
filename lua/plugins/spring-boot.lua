-- sudo -E nvim /usr/share/nvim/runtime/lua/vim/lsp/inlay_hint.lua +:355
return {
	"JavaHello/spring-boot.nvim",
	dependencies = {
		"mfussenegger/nvim-jdtls",
		"ibhagwan/fzf-lua",
		{
			"mason-org/mason.nvim",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "vscode-spring-boot-tools")
			end,
		},
	},
	ft = { "java", "yaml", "jproperties" },
	-- enabled = vim.g.ci_enabled,
	config = function()
		-- Analyse uniquement à la sauvegarde pour éviter les freezes sur les
		-- gros projets. Spring Boot LS reste utile pour les hovers/completions
		-- Spring mais n'a pas besoin de ré-analyser à chaque frappe.
		-- On intercepte client.notify pour shunter textDocument/didChange, puis
		-- on renvoie manuellement didSave sur BufWritePost — car désactiver
		-- didChange via change=0 court-circuite aussi le handler save natif.
		local group = vim.api.nvim_create_augroup("spring_boot_save_only", { clear = true })

		local function is_spring_boot(client)
			return client.name == "spring-boot"
				or client.name:match("spring")
				or client.name:match("boot")
				or client.name == "smartls"
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = group,
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client or not is_spring_boot(client) then
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

		vim.api.nvim_create_autocmd("BufWritePost", {
			group = group,
			callback = function(args)
				for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
					if is_spring_boot(client) then
						local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
						local text = table.concat(lines, "\n")
						if vim.bo[args.buf].eol then
							text = text .. "\n"
						end
						client.notify("textDocument/didSave", {
							textDocument = { uri = vim.uri_from_bufnr(args.buf) },
							text = text,
						})
					end
				end
			end,
		})

		local ls_path = vim.fn.expand(
			"$MASON/packages/vscode-spring-boot-tools/extension/language-server/spring-boot-language-server-*.jar"
		)
		require("spring_boot").setup({
			jdtls_name = "jdtls",
			exploded_ls_jar_data = false,
			server = {
				cmd = {
					"java",
					"-XX:TieredStopAtLevel=1",
					"-Xmx4G",
					"-XX:+UseZGC",
					"-Dsts.lsp.client=vscode",
					"-Dsts.log.file=" .. os.getenv("HOME") .. "/.local/state/nvim/spring-boot.log",
					"-jar",
					ls_path,
				},
			},
		})
		require("spring_boot").init_lsp_commands()
	end,
}
