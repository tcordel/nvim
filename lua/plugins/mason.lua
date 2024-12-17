return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = { "xmlformatter", "powershell-editor-services", "bash-language-server" },
		registries = {
			"github:mason-org/mason-registry",
			"github:nvim-java/mason-registry",
		},
	},
}
