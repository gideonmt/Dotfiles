return {
   "nvim-telescope/telescope.nvim",
   dependencies = { "nvim-lua/plenary.nvim" },
   config = function()
      require("telescope").setup({
         defaults = {
            file_ignore_patterns = { "node_modules", ".git", ".next" },
            mappings = {
               i = {
                  ["<C-j>"] = "move_selection_next",
                  ["<C-k>"] = "move_selection_previous",
               },
            },
         },
      })
      
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>f", function()
         builtin.find_files({ hidden = true, no_ignore = true })
      end)
      vim.keymap.set("n", "<leader>g", builtin.live_grep)
      vim.keymap.set("n", "<leader>b", builtin.buffers)
      vim.keymap.set("n", "<leader>h", builtin.help_tags)
      vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
   end,
}
