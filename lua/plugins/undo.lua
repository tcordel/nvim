return {
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>su",
        function()
          vim.cmd.UndotreeToggle()
        end,
        desc = "Show undo tree",
      },
    },
  },
}
