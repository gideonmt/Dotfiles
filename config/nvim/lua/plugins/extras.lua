return {
   { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },
   { "windwp/nvim-ts-autotag", opts = {} },
   {
      "norcalli/nvim-colorizer.lua",
      config = function()
         require("colorizer").setup()
      end,
   },
   {
      "yamatsum/nvim-cursorline",
      opts = {
         cursorword = {
            enable = true,
            min_length = 3,
            hl = { underline = true },
         },
         cursorline = { enable = false },
      },
   },
}
