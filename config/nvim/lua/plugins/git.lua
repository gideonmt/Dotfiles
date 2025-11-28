return {
   {
      "lewis6991/gitsigns.nvim",
      opts = {
         signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
         },
         on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local map = function(mode, l, r, opts)
               opts = opts or {}
               opts.buffer = bufnr
               vim.keymap.set(mode, l, r, opts)
            end
            
            -- Navigation
            map("n", "]c", function()
               if vim.wo.diff then return "]c" end
               vim.schedule(function() gs.next_hunk() end)
               return "<Ignore>"
            end, { expr = true })
            
            map("n", "[c", function()
               if vim.wo.diff then return "[c" end
               vim.schedule(function() gs.prev_hunk() end)
               return "<Ignore>"
            end, { expr = true })
            
            -- Actions
            map("n", "<Leader>gs", gs.stage_hunk)
            map("n", "<Leader>gr", gs.reset_hunk)
            map("n", "<Leader>gS", gs.stage_buffer)
            map("n", "<Leader>gu", gs.undo_stage_hunk)
            map("n", "<Leader>gR", gs.reset_buffer)
            map("n", "<Leader>gp", gs.preview_hunk)
            map("n", "<Leader>gb", function() gs.blame_line({ full = true }) end)
            map("n", "<Leader>gd", gs.diffthis)
         end,
      },
   },
   {
      "tpope/vim-fugitive",
      keys = {
         { "<Leader>gg", ":Git<CR>" },
         { "<Leader>gc", ":Git commit<CR>" },
         { "<Leader>gp", ":Git push<CR>" },
         { "<Leader>gl", ":Git pull<CR>" },
      },
   },
}
