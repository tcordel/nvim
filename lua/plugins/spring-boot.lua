return {
	"JavaHello/spring-boot.nvim",
	ft = "java",
	dependencies = {
		"mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
		-- "ibhagwan/fzf-lua", -- optional
	},
	config = function()
		-- require("spring_boot").setup({
		-- 	-- ls_path = os.getenv("HOME") .. "/.vscode/extensions/vmware.vscode-spring-boot-1.58.0/language-server",
		-- 	-- jdtls_name = "jdtls",
		-- 	java_cmd = "java",
		-- 	log_file = os.getenv("HOME") .. "/.local/state/nvim/spring-boot.log",
		-- })
		-- require("spring_boot").init_lsp_commands()
	end,
}
