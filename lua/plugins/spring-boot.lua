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
				table.insert(opts.ensure_installed, "spring-boot-tools")
			end,
		},
	},
	ft = { "java", "yaml", "jproperties" },
	enabled = vim.g.ci_enabled,
	config = function()
		local ls_path = vim.fn.expand(
			"$MASON/packages/spring-boot-tools/extension/language-server/spring-boot-language-server-*.jar"
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
