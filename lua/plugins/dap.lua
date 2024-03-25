return {
  "mfussenegger/nvim-dap",
  name = "dap",
  event = "LspAttach",
  dependencies = {
    "dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  --  config = function()
  --    require("nvim.plugin.dap.setup")
  --    require("nvim.plugin.dap.keymap")
  --    require("nvim.plugin.dap.configs.python")
  --  end,
}
