require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.commands")

vim.api.nvim_create_autocmd("PackChanged", {
   callback = function(ev)
      local name, kind = ev.data.spec.name, ev.data.kind
      if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
         if not ev.data.active then
            vim.cmd.packadd("nvim-treesitter")
         end
         vim.cmd("TSUpdate")
      end
   end,
})

vim.pack.add({
   -- LSP
   { src = "https://github.com/williamboman/mason.nvim" },
   { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
   { src = "https://github.com/neovim/nvim-lspconfig" },

   -- Completion
   { src = "https://github.com/hrsh7th/nvim-cmp" },
   { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
   { src = "https://github.com/hrsh7th/cmp-buffer" },
   { src = "https://github.com/hrsh7th/cmp-path" },
   { src = "https://github.com/hrsh7th/cmp-cmdline" },

   -- Treesitter
   { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
   { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },

   -- Telescope
   { src = "https://github.com/nvim-telescope/telescope.nvim" },
   { src = "https://github.com/nvim-lua/plenary.nvim" },

   -- UI
   { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
   { src = "https://github.com/nvim-lualine/lualine.nvim" },
   { src = "https://github.com/nvim-tree/nvim-web-devicons" },
   { src = "https://github.com/akinsho/bufferline.nvim" },
   { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
   { src = "https://github.com/rcarriga/nvim-notify" },

   -- Git
   { src = "https://github.com/lewis6991/gitsigns.nvim" },
   { src = "https://github.com/tpope/vim-fugitive" },

   -- Editor enhancements
   { src = "https://github.com/kylechui/nvim-surround" },
   { src = "https://github.com/norcalli/nvim-colorizer.lua" },
   { src = "https://github.com/yamatsum/nvim-cursorline" },
   { src = "https://github.com/chentoast/marks.nvim" },
   { src = "https://github.com/stevearc/oil.nvim" },
   { src = "https://github.com/sitiom/nvim-numbertoggle" },
   { src = "https://github.com/jbyuki/venn.nvim" },
   
   -- LaTeX
   { src = "https://github.com/lervag/vimtex" },

   -- Typst
   { src = "https://github.com/kaarmu/typst.vim"},
}, {
   load = true,
   confirm = true,
})

require("plugins.completion")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.ui")
require("plugins.git")
require("plugins.editor")
