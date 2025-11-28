local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better window navigation (no trackpad needed)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Window resizing
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Tab navigation
map("n", "<Leader>tn", ":tabnew<CR>", opts)
map("n", "<Leader>tc", ":tabclose<CR>", opts)
map("n", "<Leader>to", ":tabonly<CR>", opts)
map("n", "H", ":tabprevious<CR>", opts)
map("n", "L", ":tabnext<CR>", opts)

-- Buffer navigation
map("n", "[b", ":bprevious<CR>", opts)
map("n", "]b", ":bnext<CR>", opts)
map("n", "<Leader>bd", ":bdelete<CR>", opts)
map("n", "<Leader>ba", ":%bdelete|edit#|bdelete#<CR>", opts) -- Close all but current

-- File operations
map("n", "<Leader>w", ":write<CR>", opts)
map("n", "<Leader>q", ":quit<CR>", opts)
map("n", "<Leader>Q", ":qall<CR>", opts)
map("n", "<Leader>x", ":wq<CR>", opts)

-- System clipboard
map({"n", "v"}, "<Leader>y", '"+y', opts)
map("n", "<Leader>Y", '"+y$', opts)
map({"n", "v"}, "<Leader>p", '"+p', opts)
map({"n", "v"}, "<Leader>P", '"+P', opts)

-- Better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Quick fix and location list
map("n", "[q", ":cprevious<CR>", opts)
map("n", "]q", ":cnext<CR>", opts)
map("n", "[Q", ":cfirst<CR>", opts)
map("n", "]Q", ":clast<CR>", opts)
map("n", "<Leader>co", ":copen<CR>", opts)
map("n", "<Leader>cc", ":cclose<CR>", opts)

-- Center screen after jumps
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Join lines without moving cursor
map("n", "J", "mzJ`z", opts)

-- Clear highlights on ESC
map("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Commenting (built-in)
map("n", "gcc", function()
   local line = vim.api.nvim_get_current_line()
   local cs = vim.bo.commentstring
   local comment_leader = cs:match("^(.-)%%s") or "#"
   
   if line:match("^%s*" .. vim.pesc(comment_leader)) then
      -- Uncomment
      vim.api.nvim_set_current_line(line:gsub("^(%s*)" .. vim.pesc(comment_leader) .. "%s?", "%1"))
   else
      -- Comment
      local indent = line:match("^%s*")
      vim.api.nvim_set_current_line(indent .. comment_leader .. " " .. line:sub(#indent + 1))
   end
end, opts)

map("v", "gc", function()
   local cs = vim.bo.commentstring
   local comment_leader = cs:match("^(.-)%%s") or "#"
   
   vim.cmd("'<,'>s/^/" .. vim.fn.escape(comment_leader .. " ", "/\\") .. "/")
   vim.cmd("nohlsearch")
end, opts)

-- Quick source current file
map("n", "<Leader>s", ":source %<CR>", opts)

-- Navigate to config
map("n", "<Leader>v", ":cd ~/.config/nvim/<CR>:Telescope find_files<CR>", opts)

-- LSP (will be set in LSP config too)
map("n", "<Leader>d", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
