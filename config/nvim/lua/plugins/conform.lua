return {
   "stevearc/conform.nvim",
   opts = {
      formatters_by_ft = {
         lua = { "stylua" },
         python = { "black" },
      },
      format_after_save = {
         -- disable for css and scss
         ["css"] = false,
         ["scss"] = false,
         -- enable for all other filetypes
         ["*"] = true,
      },
   },
}
