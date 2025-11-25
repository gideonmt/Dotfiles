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
         "kdheepak/cmp-latex-symbols",
         "L3MON4D3/LuaSnip",
         "saadparwaiz1/cmp_luasnip",
         "onsails/lspkind.nvim",
         "zbirenbaum/copilot-cmp",
      },
      config = function()
         local cmp = require("cmp")
         local lspkind = require("lspkind")
         local luasnip = require("luasnip")

         -- Load custom snippets
         require("config.snippets")

         cmp.setup({
            snippet = {
               expand = function(args)
                  luasnip.lsp_expand(args.body)
               end,
            },
            window = {
               completion = cmp.config.window.bordered(),
               documentation = cmp.config.window.bordered(),
            },
            mapping = {
               ["<CR>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                     cmp.confirm({ select = true })
                  else
                     fallback() -- newline
                  end
               end, { "i", "s" }),

               ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                     cmp.select_next_item()
                  elseif luasnip.expand_or_jumpable() then
                     luasnip.expand_or_jump()
                  else
                     fallback() -- real tab
                  end
               end, { "i", "s" }),

               ["<S-Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                     cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                     luasnip.jump(-1)
                  else
                     fallback()
                  end
               end, { "i", "s" }),

               ["<C-b>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<Down>"] = cmp.mapping.select_next_item(),
               ["<Up>"] = cmp.mapping.select_prev_item(),
            },
            sources = cmp.config.sources({
               { name = "copilot", priority = 1000, group_index = 1 },
               { name = "nvim_lsp", group_index = 2 },
               { name = "luasnip", group_index = 2 },
               { name = "nvim_lua", group_index = 2 },
               { name = "latex_symbols", group_index = 2 },
               { name = "buffer", group_index = 2 },
               { name = "path", group_index = 2 },
               { name = "spell", group_index = 2 },
            }),
            formatting = {
               format = lspkind.cmp_format({
                  mode = "symbol_text",
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
                        local label = entry.completion_item.newText or ""
                        if #label > 60 then
                           vim_item.kind = " Short"
                        else
                           vim_item.kind = " Long"
                        end
                     end
                     return vim_item
                  end,
               }),
            },
         })

         -- Cmdline completion
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

   -- Copilot core (only through cmp)
   {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      config = function()
         require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
               markdown = true,
               ["*"] = false,
               gitcommit = true,
            },
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
