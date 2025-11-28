local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.scrolloff = 10
opt.splitkeep = "screen"
opt.splitright = true
opt.splitbelow = true
opt.mousemoveevent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Indentation
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true

-- Files
opt.swapfile = false
opt.undofile = true

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "
