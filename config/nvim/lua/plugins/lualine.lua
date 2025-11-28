return {
   "nvim-lualine/lualine.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
      require("lualine").setup({
         options = {
            theme = {
               normal = { c = { fg = "#be95ff" } },
               inactive = { c = { fg = "#be95ff" } },
            },
            section_separators = "",
            component_separators = { left = "──", right = "──" },
         },
         sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
               { "branch", icon = "", color = { fg = "#be95ff" } },
               { "diff" },
               { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
               "%=",
               { "filetype", colored = false, icon_only = true, separator = "∙" },
               { "filename", path = 1, symbols = { modified = "●" }, color = { fg = "#be95ff" } },
            },
            lualine_x = {},
            lualine_y = {},
            lualine_z = { { "progress", color = { fg = "#be95ff" } } },
         },
      })
      
      vim.opt.showmode = false
      vim.opt.fillchars = { stl = "─", stlnc = "─" }
   end,
}
