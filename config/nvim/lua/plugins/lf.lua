-- lf.lua for lazy.nvim installation
return {
   "lmburns/lf.nvim",
   config = function()
      -- Set `lf` as default file manager, replacing `netrw`
      vim.g.lf_netrw = 1

      -- Plugin setup with custom configuration
      require("lf").setup({
         default_action = "drop",
         default_actions = {
            ["<C-t>"] = "tabedit",
            ["<C-x>"] = "split",
            ["<C-v>"] = "vsplit",
            ["<C-o>"] = "tab drop",
         },
         winblend = 10,
         dir = "",
         direction = "float",
         border = "rounded",
         escape_quit = true,
         focus_on_open = true,
         mappings = true,
         tmux = false,
         default_file_manager = false,
         disable_netrw_warning = true,
         highlights = {
            Normal = { link = "Normal" },
            NormalFloat = { link = "Normal" },
            FloatBorder = { guifg = "#819C3B" },
         },
         layout_mapping = "<M-u>",
         views = {
            { width = 0.800, height = 0.800 },
            { width = 0.600, height = 0.600 },
            { width = 0.950, height = 0.950 },
            { width = 0.500, height = 0.500, col = 0,   row = 0 },
            { width = 0.500, height = 0.500, col = 0,   row = 0.5 },
            { width = 0.500, height = 0.500, col = 0.5, row = 0 },
            { width = 0.500, height = 0.500, col = 0.5, row = 0.5 },
         },
      })

      -- Key mappings
      vim.keymap.set("n", "<D-o>", "<Cmd>Lf<CR>", { noremap = true })
      vim.api.nvim_create_autocmd("User", {
         pattern = "LfTermEnter",
         callback = function(a)
            vim.api.nvim_buf_set_keymap(a.buf, "t", "q", "q", { nowait = true })
         end,
      })
   end,
   dependencies = { "akinsho/toggleterm.nvim" }, -- Specify dependency
}
