return {
    "stevearc/conform.nvim",
    opts = {
        lang_to_formatters = {
            json = { "jq" },
        },
        formatters_by_ft = {
            markdown = { "prettier" },
            javascript = { "prettier" },
            typescript = { "prettier" },
        },
    },
}
