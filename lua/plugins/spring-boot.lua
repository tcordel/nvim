return {
	"JavaHello/spring-boot.nvim",
	dependencies = {
		"mfussenegger/nvim-jdtls",
		{
			"williamboman/mason.nvim",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "spring-boot-tools")
			end,
		},
	},
	ft = "java",
	-- config = function()
	-- 	require("spring_boot").setup({
	-- 		java_cmd = "java",
	-- 		log_file = os.getenv("HOME") .. "/.local/state/nvim/spring-boot.log",
	-- 	})
	-- 	require("spring_boot").init_lsp_commands()
	-- end,
}
