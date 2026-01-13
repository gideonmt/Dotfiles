-- Core settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
--opt.cursorline = true
opt.scrolloff = 10
opt.splitright = true
opt.splitbelow = true
--opt.signcolumn = "yes"
--opt.showmode = false

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Indentation
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Files
opt.undofile = true
opt.swapfile = false

-- Performance
opt.updatetime = 250

-- Disable mouse
opt.mouse = ""

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Spell check settings
opt.spell = false
--opt.spellopts = "camel"

-- Plugin manager
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

   -- Snippets
   { src = "https://github.com/L3MON4D3/LuaSnip" },
   { src = "https://github.com/saadparwaiz1/cmp_luasnip" },

   -- Telescope
   { src = "https://github.com/nvim-telescope/telescope.nvim" },
   { src = "https://github.com/nvim-lua/plenary.nvim" },

   -- Theme
   { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },

   -- Git
   { src = "https://github.com/lewis6991/gitsigns.nvim" },
   { src = "https://github.com/tpope/vim-fugitive" },

   -- Utilities
   { src = "https://github.com/jbyuki/venn.nvim" },
   { src = "https://github.com/lervag/vimtex" },
}, {
   load = true,
})

-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Buffer navigation
map("n", "[b", ":bprevious<CR>", opts)
map("n", "]b", ":bnext<CR>", opts)
map("n", "<Leader>bd", ":bdelete<CR>", opts)

-- File operations
map("n", "<Leader>w", ":write<CR>", opts)
map("n", "<Leader>q", ":quit<CR>", opts)

-- Better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Spell check
map("n", "z=", "z=", opts)  -- Fix spelling under cursor
map("n", "]s", "]s", opts)  -- Next misspelled word
map("n", "[s", "[s", opts)  -- Previous misspelled word

-- Clear highlights
map("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Diagnostic navigation
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)

-- Autocmds
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
   callback = function()
      vim.highlight.on_yank({ timeout = 200 })
   end,
})

-- Spell check for text files only
autocmd("FileType", {
   pattern = { "markdown", "text", "tex" },
   callback = function()
      vim.opt_local.spell = true
   end,
})

-- Setup theme
vim.cmd.colorscheme("oxocarbon")

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
   ensure_installed = {
      "lua_ls",
      "pyright",
      "texlab",
   },
   automatic_installation = true,
})

-- LSP setup
local on_attach = function(client, bufnr)
   local opts = { buffer = bufnr }
   map("n", "gd", vim.lsp.buf.definition, opts)
   map("n", "gr", vim.lsp.buf.references, opts)
   map("n", "K", vim.lsp.buf.hover, opts)
   map("n", "<Leader>rn", vim.lsp.buf.rename, opts)
   map("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
   map("n", "<Leader>f", function()
      vim.lsp.buf.format({ async = true })
   end, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configure servers
local servers = {
   lua_ls = {
      settings = {
         Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
         },
      },
   },
   pyright = {},
   texlab = {},
}

for server, config in pairs(servers) do
   config.capabilities = capabilities
   vim.lsp.config(server, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
         on_attach(client, args.buf)
      end
   end,
})

-- Completion setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   mapping = cmp.mapping.preset.insert({
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
         else
            fallback()
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
   }),
   sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
   },
})

-- Load snippets
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })

-- Telescope setup
local telescope = require("telescope")

telescope.setup({
   defaults = {
      file_ignore_patterns = { "node_modules", ".git/" },
   },
})

local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fh", builtin.help_tags)

-- Gitsigns setup
require("gitsigns").setup({
   signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
   },
   on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map_gs(mode, l, r, desc)
         map(mode, l, r, { buffer = bufnr, desc = desc })
      end
      
      map_gs("n", "]c", gs.next_hunk, "Next hunk")
      map_gs("n", "[c", gs.prev_hunk, "Previous hunk")
      map_gs("n", "<Leader>gs", gs.stage_hunk, "Stage hunk")
      map_gs("n", "<Leader>gr", gs.reset_hunk, "Reset hunk")
      map_gs("n", "<Leader>gp", gs.preview_hunk, "Preview hunk")
   end,
})

-- Fugitive keybindings
map("n", "<Leader>gg", ":Git<CR>")
map("n", "<Leader>gc", ":Git commit<CR>")
map("n", "<Leader>gP", ":Git push<CR>")

-- Venn toggle
function _G.Toggle_venn()
   local venn_enabled = vim.b.venn_enabled
   if not venn_enabled then
      vim.b.venn_enabled = true
      vim.cmd("setlocal ve=all")
      map("n", "J", "<C-v>j:VBox<CR>", { buffer = true })
      map("n", "K", "<C-v>k:VBox<CR>", { buffer = true })
      map("n", "L", "<C-v>l:VBox<CR>", { buffer = true })
      map("n", "H", "<C-v>h:VBox<CR>", { buffer = true })
      map("v", "f", ":VBox<CR>", { buffer = true })
   else
      vim.cmd("setlocal ve=")
      vim.keymap.del("n", "J", { buffer = true })
      vim.keymap.del("n", "K", { buffer = true })
      vim.keymap.del("n", "L", { buffer = true })
      vim.keymap.del("n", "H", { buffer = true })
      vim.keymap.del("v", "f", { buffer = true })
      vim.b.venn_enabled = nil
   end
end

map("n", "<leader>V", ":lua Toggle_venn()<CR>")
