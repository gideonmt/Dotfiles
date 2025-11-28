return {
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
         require("nvim-treesitter.configs").setup({
            auto_install = true,
            ensure_installed = {
               "c", "cpp", "python", "lua", "vim", "vimdoc",
               "html", "css", "javascript", "typescript", "tsx",
               "json", "yaml", "toml", "markdown",
               "java", "go", "rust",
            },
            highlight = { enable = true },
            indent = { enable = true },
         })
      end,
   },
   {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = "nvim-treesitter/nvim-treesitter",
      config = function()
         require("nvim-treesitter.configs").setup({
            textobjects = {
               select = {
                  enable = true,
                  lookahead = true,
                  keymaps = {
                     ["af"] = "@function.outer",
                     ["if"] = "@function.inner",
                     ["ac"] = "@class.outer",
                     ["ic"] = "@class.inner",
                     ["aa"] = "@parameter.outer",
                     ["ia"] = "@parameter.inner",
                  },
               },
            },
         })
      end,
   },
}
