local ls = require("luasnip")

-- load snippets from lua/LuaSnip/ directory
require("luasnip.loaders.from_lua").load({
   paths = "~/.config/nvim/lua/LuaSnips/",
})

-- configure Luasnip behavior
ls.config.set_config({
   history = true,
   updateevents = "TextChanged,TextChangedI",
   enable_autosnippets = true,
})

-- (optional) keymaps for manual expansion/jumping
vim.keymap.set({ "i", "s" }, "<C-k>", function()
   ls.expand_or_jump()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-j>", function()
   ls.jump(-1)
end, { silent = true })
