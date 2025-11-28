return {
   {
      "nyoom-engineering/oxocarbon.nvim",
      priority = 1000,
      config = function()
         vim.cmd.colorscheme("oxocarbon")
         vim.opt.background = "dark"
         
         vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
               vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#b4befe" })
               vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#b4befe" })
               vim.api.nvim_set_hl(0, "IblScope", { fg = "#b4befe" })
            end,
         })
      end,
   },
   {
      "rcarriga/nvim-notify",
      config = function()
         vim.notify = require("notify")
      end,
   },
}
