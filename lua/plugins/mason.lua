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
			"vscode-spring-boot-tools",
			"groovy-language-server",
			"lemminx",
			"chrome-debug-adapter",

		},
		registries = {
			"github:mason-org/mason-registry",
			"github:tcordel/mason-registry",
			-- "github:nvim-java/mason-registry",
		},
	},
}
