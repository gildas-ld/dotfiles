-- Normal mode navigation
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")

-- Tab navigation
vim.keymap.set("n", "<Tab>", ":tabnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>")
vim.keymap.set("n", "<S-t>", ":tabnew<CR>", { silent = true })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>")
vim.keymap.set("n", "<leader>to", ":tabonly<CR>")
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")
vim.keymap.set("n", "<leader>tm", ":tabmove")

-- Save, buffers, windows
vim.keymap.set("n", "<leader>w", ":w!<CR>")
vim.cmd("command! W w !sudo tee % > /dev/null")
vim.keymap.set("n", "<leader>z", ":bp<CR>")
vim.keymap.set("n", "<leader>x", ":bn<CR>")
vim.keymap.set("n", "<leader>c", ":bd<CR>")
vim.keymap.set("n", "<leader>rv", ":luafile $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>ev", ":tabnew $MYVIMRC<CR>")

-- Paste mode
vim.keymap.set("n", "<F2>", ":set invpaste paste?<CR>")
vim.keymap.set("i", "<F2>", "<C-o>:set invpaste paste?<CR>")

-- Escape shortcuts
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", ";;", "<Esc>")

-- Move lines
vim.cmd([[
nnoremap <C-UP> :<C-u>silent! move-2<CR>==
nnoremap <C-DOWN> :<C-u>silent! move+<CR>==
xnoremap <C-UP> :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <C-DOWN> :<C-u>silent! '<,'>move'>+<CR>gv=gv
]])

-- Insert shortcuts
vim.cmd([[
inoremap $1 ()<Esc>i
inoremap $2 []<Esc>i
inoremap $3 {}<Esc>i
inoremap $q ''<Esc>i
inoremap $e ""<Esc>i
iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<CR>
]])
