local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

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
