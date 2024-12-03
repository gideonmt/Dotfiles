return {
   {
      "nyoom-engineering/oxocarbon.nvim",
      name = "oxocarbon",
      priority = 1000,
      init = function()
         vim.cmd.colorscheme("oxocarbon")
         vim.opt.background = "dark"
      end,
   },
   {
      "rcarriga/nvim-notify",
      config = function()
         vim.notify = require("notify")
      end,
   },
}
