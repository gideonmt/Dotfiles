local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
autocmd("TextYankPost", {
   group = augroup("HighlightYank", { clear = true }),
   callback = function()
      vim.highlight.on_yank({ timeout = 200 })
   end,
})

-- Disable auto comment
autocmd("BufEnter", {
   group = augroup("DisableAutoComment", { clear = true }),
   callback = function()
      vim.opt.formatoptions:remove({ "c", "r", "o" })
   end,
})

-- Spell check for markdown
autocmd("FileType", {
   group = augroup("MarkdownSpell", { clear = true }),
   pattern = { "markdown", "text" },
   callback = function()
      vim.opt_local.spell = true
   end,
})

-- Language-specific settings
autocmd("FileType", {
   group = augroup("LuaSettings", { clear = true }),
   pattern = "lua",
   callback = function()
      vim.opt_local.shiftwidth = 3
      vim.opt_local.tabstop = 3
      vim.opt_local.softtabstop = 3
   end,
})

-- Run programs by filetype
local RunGroup = augroup("QuickRun", { clear = true })

autocmd("FileType", {
   group = RunGroup,
   pattern = "cpp",
   callback = function()
      vim.keymap.set("n", "<Leader>r", ":split | terminal ./a.out<CR>", { buffer = true })
   end,
})

autocmd("FileType", {
   group = RunGroup,
   pattern = "go",
   callback = function()
      vim.keymap.set("n", "<Leader>r", ":split | terminal go run %<CR>", { buffer = true })
   end,
})

autocmd("FileType", {
   group = RunGroup,
   pattern = "python",
   callback = function()
      vim.keymap.set("n", "<Leader>r", ":split | terminal python3 %<CR>", { buffer = true })
   end,
})

-- Markdown auto-compile
autocmd("BufWritePost", {
   group = augroup("MarkdownAutoPDF", { clear = true }),
   pattern = "*.md",
   callback = function()
      vim.cmd("silent! MdPDF")
   end,
})

-- Disable arrow keys (force hjkl)
local function warn_arrows()
   vim.notify("Use hjkl instead of arrow keys", vim.log.levels.WARN)
end

for _, key in ipairs({ "<Up>", "<Down>" }) do
   vim.keymap.set({ "n", "i", "v" }, key, warn_arrows, { noremap = true })
end
