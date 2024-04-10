local wk = require("which-key")
wk.register({
    ["<leader>r"] = { name = "+refactoring" },
})
return {
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup({})
        end,
        keys = {
            { "<leader>re", "<Cmd>:Refactor extract<CR>", desc = "extract" },
            { "<leader>rf", "<Cmd>:Refactor extract_to_file<CR>", desc = "extract_to_file" },
            { "<leader>rv", "<Cmd>Refactor extract_var<CR>", desc = "extract_var" },
            { "<leader>ri", "<Cmd>Refactor inline_var<CR>", desc = "inline_var" },
            { "<leader>rI", "<Cmd>Refactor inline_func<CR>", desc = "Refactor inline_func" },
            { "<leader>rb", "<Cmd>Refactor extract_block<CR>", desc = "Refactor extract_block" },
            { "<leader>rbf", "<Cmd>Refactor extract_block_to_file<CR>", desc = "Refactor extract_block_to_file" },
        },
    },
}
