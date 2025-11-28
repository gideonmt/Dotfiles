return {
   {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {},
   },
   {
      "m4xshen/smartcolumn.nvim",
      opts = {
         disabled_filetypes = {
            "lazy", "mason", "help", "text", "markdown", "tex", "html",
         },
         scope = "window",
      },
   },
}
