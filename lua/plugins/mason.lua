return {
	"williamboman/mason.nvim",
	opts = {
		PATH = "prepend",
		ensure_installed = {
			"xmlformatter",
			"powershell-editor-services",
			"bash-language-server",
			"lua-language-server",
			"jdtls",
			"sonarlint-language-server",
			"spring-boot-tools",
			"groovy-language-server",
			"lemminx"
		},
		registries = {
			"github:mason-org/mason-registry",
			"github:nvim-java/mason-registry",
		},
	},
}
