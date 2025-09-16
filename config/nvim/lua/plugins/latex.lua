return {
   {
      "lervag/vimtex",
      config = function()
         vim.cmd([[
            filetype plugin indent on
            let g:vimtex_view_method = 'zathura'
            let g:vimtex_quickfix_mode = 0
            let g:vimtex_mappings_enabled = 1
            let g:vimtex_compiler_latexmk = {
               \ 'build_dir' : '',
               \ 'callback' : 1,
               \ 'continuous' : 1,
               \ 'executable' : 'latexmk',
               \ 'options' : [
               \   '-pdf',
               \   '-shell-escape',
               \   '-verbose',
               \   '-file-line-error',
               \   '-synctex=1',
               \   '-interaction=nonstopmode',
               \ ],
               \}
         ]])
      end,
   },
   {
      "kylechui/nvim-surround",
      event = "VeryLazy",
      config = function()
         require("nvim-surround").setup()
      end,
   },
   {
      "KeitaNakamura/tex-conceal.vim",
      ft = { "tex" },
      config = function()
         vim.g.tex_conceal = "abdmg"
         vim.opt.conceallevel = 2
      end,
   },
}
