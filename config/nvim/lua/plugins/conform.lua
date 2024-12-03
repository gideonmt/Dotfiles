return {
   "stevearc/conform.nvim",
   opts = {
      formatters_by_ft = {
         lua = { "stylua" },
         python = { "black" },
         javascript = { "prettier" },
         javascriptreact = { "prettier" },
         typescript = { "prettier" },
         typescriptreact = { "prettier" },
      },
      format_after_save = {
         lsp_format = "fallback",
      },
   },
}
