return {
   {
      "numToStr/Comment.nvim",
      opts = {
         pre_hook = function()
            return vim.bo.commentstring
         end,
      },
   },
   {
      "JoosepAlviste/nvim-ts-context-commentstring",
   },
}
