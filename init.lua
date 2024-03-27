-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local dap = require("dap")
dap.configurations.java = {
  {
    name = "Debug (Attach) - Remote",
    type = "java",
    request = "attach",
    hostName = "127.0.0.1",
    port = 2000,
  },
}
