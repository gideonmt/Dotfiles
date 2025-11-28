return {
   "lervag/vimtex",
   ft = "tex",
   init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_syntax_conceal_disable = 0
      vim.g.tex_conceal = "abdmg"
      vim.opt.conceallevel = 2
      vim.g.vimtex_compiler_latexmk = {
         build_dir = "",
         callback = 1,
         continuous = 1,
         executable = "latexmk",
         options = {
            "-pdf",
            "-interaction=nonstopmode",
            "-synctex=1",
         },
      }
   end,
   keys = {
      { "<Leader>ll", ":VimtexCompile<CR>" },
      { "<Leader>lv", ":VimtexView<CR>" },
   },
}
