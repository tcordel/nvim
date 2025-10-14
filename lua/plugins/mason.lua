return {
	"mason-org/mason.nvim",
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
			"lemminx",
			"chrome-debug-adapter"
		},
		registries = {
			-- "github:tcordel/mason-registry",
			"github:mason-org/mason-registry",
			"github:nvim-java/mason-registry",
		},
	},
}
