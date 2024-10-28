return {
	"JavaHello/spring-boot.nvim",
	ft = "java",
	dependencies = {
		"mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig

		{
			"williamboman/mason.nvim",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "spring-boot-tools")
			end,
		},
	},
}
