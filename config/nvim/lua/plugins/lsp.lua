return {
   "neovim/nvim-lspconfig",
   dependencies = { "hrsh7th/cmp-nvim-lsp" },
   config = function()
      -- Diagnostic config
      vim.diagnostic.config({
         float = { border = "rounded" },
         virtual_text = false,
         signs = {
            text = {
               [vim.diagnostic.severity.ERROR] = "",
               [vim.diagnostic.severity.WARN] = "",
               [vim.diagnostic.severity.HINT] = "",
               [vim.diagnostic.severity.INFO] = "",
            },
         },
         underline = true,
      })
      
      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
         callback = function(args)
            local opts = { buffer = args.buf }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<Leader>f", function()
               vim.lsp.buf.format({ async = true })
            end, opts)
         end,
      })
      
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- Server configs
      local servers = {
         lua_ls = {
            settings = {
               Lua = {
                  diagnostics = { globals = { "vim" } },
                  workspace = { checkThirdParty = false },
               },
            },
         },
         clangd = {},
         html = {},
         cssls = {},
         ts_ls = {},
         eslint = {},
         pyright = {},
         gopls = {},
         texlab = {},
      }
      
      for server, config in pairs(servers) do
         config.capabilities = capabilities
         vim.lsp.config(server, config)
      end
      
      vim.lsp.enable(vim.tbl_keys(servers))
   end,
}
