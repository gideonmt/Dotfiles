return {
   -- Main completion engine
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
         "hrsh7th/cmp-nvim-lua",
         "f3fora/cmp-spell",
         "L3MON4D3/LuaSnip",
         "saadparwaiz1/cmp_luasnip",
         "onsails/lspkind.nvim",
         "zbirenbaum/copilot-cmp",
      },
      config = function()
         local cmp = require("cmp")
         local lspkind = require("lspkind")
         local luasnip = require("luasnip")

         -- LuaSnip jump helpers
         vim.keymap.set({ "i", "s" }, "<C-L>", function()
            luasnip.jump(1)
         end, { silent = true })
         vim.keymap.set({ "i", "s" }, "<C-J>", function()
            luasnip.jump(-1)
         end, { silent = true })

         cmp.setup({
            snippet = {
               expand = function(args)
                  require("luasnip").lsp_expand(args.body)
               end,
            },
            window = {
               completion = cmp.config.window.bordered(),
               documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
               ["<C-b>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<CR>"] = cmp.mapping.confirm({ select = true }),
               ["<Tab>"] = cmp.mapping.select_next_item(),
               ["<S-Tab>"] = cmp.mapping.select_prev_item(),
               ["<Down>"] = cmp.mapping.select_next_item(),
               ["<Up>"] = cmp.mapping.select_prev_item(),
            }),
            sources = cmp.config.sources({
               { name = "copilot", priority = 1000, group_index = 1 },
               { name = "nvim_lsp", group_index = 2 },
               { name = "luasnip", group_index = 2 },
               { name = "nvim_lua", group_index = 2 },
               { name = "buffer", group_index = 2 },
               { name = "path", group_index = 2 },
               { name = "spell", group_index = 2 },
            }),
            formatting = {
               format = lspkind.cmp_format({
                  mode = "symbol_text",
                  maxwidth = 50,
                  ellipsis_char = "...",
                  menu = {
                     buffer = "[Buffer]",
                     nvim_lsp = "[LSP]",
                     nvim_lua = "[Lua]",
                     luasnip = "[Snippet]",
                     path = "[Path]",
                     spell = "[Spell]",
                     copilot = "[Copilot]",
                  },
                  before = function(entry, vim_item)
                     if entry.source.name == "copilot" then
                        if #entry.completion_item.label < 60 then
                           vim_item.kind = " [Copilot] Short"
                        else
                           vim_item.kind = " [Copilot] Long"
                        end
                     end
                     return vim_item
                  end,
               }),
            },
            enabled = function()
               local context = require("cmp.config.context")
               if vim.api.nvim_get_mode().mode == "c" then
                  return true
               else
                  return not context.in_treesitter_capture("comment")
                     and not context.in_syntax_group("Comment")
               end
            end,
         })

         -- Cmdline and search completion
         cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = "buffer" } },
         })
         cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
               { { name = "path" } },
               { { name = "cmdline" } }
            ),
         })
      end,
   },

   -- Copilot (core, disable floating suggestions, only use cmp menu)
   {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      config = function()
         require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
         })
      end,
   },
   {
      "zbirenbaum/copilot-cmp",
      dependencies = { "zbirenbaum/copilot.lua" },
      config = function()
         require("copilot_cmp").setup({})
      end,
   },
}
