return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = { "xmlformatter" },
		registries = {
			"github:mason-org/mason-registry",
			"github:nvim-java/mason-registry",
		},
	},
}
