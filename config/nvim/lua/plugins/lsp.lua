--- LSP configuration

-- global diagnostic keymaps
vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

-- diagnostic display config
vim.diagnostic.config({
   float = { border = "rounded" },
   virtual_text = false,
   signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = "",
         [vim.diagnostic.severity.WARN] = "",
         [vim.diagnostic.severity.HINT] = "",
         [vim.diagnostic.severity.INFO] = "",
      },
   },
   underline = true,
})

-- LspAttach autocmd for buffer-local keymaps
vim.api.nvim_create_autocmd("LspAttach", {
   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
   callback = function(ev)
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set(
         "n",
         "<Leader>a",
         vim.lsp.buf.code_action,
         { buffer = ev.buf, noremap = true, silent = true }
      )
   end,
})

local languages = {
   "clangd",
   "html",
   "cssls",
   "ts_ls",
   "emmet_ls",
   "eslint",
   "pyright",
   "gopls",
   "texlab",
}

return {
   {
      "themaxmarchuk/tailwindcss-colors.nvim",
      module = "tailwindcss-colors",
      config = function()
         require("tailwindcss-colors").setup()
      end,
   },
   {
      "neovim/nvim-lspconfig",
      dependencies = { "hrsh7th/cmp-nvim-lsp" },
      config = function()
         local capabilities = require("cmp_nvim_lsp").default_capabilities()

         -- Lua LS
         vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
               Lua = {
                  diagnostics = {
                     globals = { "vim", "describe", "it" },
                  },
               },
            },
         })

         -- TailwindCSS
         vim.lsp.config("tailwindcss", {
            on_attach = function()
               require("tailwindcss-colors").buf_attach(0)
            end,
         })

         -- All other servers
         for _, language in ipairs(languages) do
            vim.lsp.config(language, {
               capabilities = capabilities,
            })
         end

         -- Enable all servers
         vim.lsp.enable(vim.list_extend({ "lua_ls", "tailwindcss" }, languages))

         -- Extra keymap for eslint
         vim.keymap.set(
            "n",
            "<Leader>e",
            ":EslintFixAll<CR>",
            { noremap = true, silent = true }
         )
      end,
   },
}
