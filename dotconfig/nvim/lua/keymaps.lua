--------------------------------------------------------------------------------
--------------------------------- Fuzzy Finder ---------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>n', "<cmd>Neotree float toggle=true<cr>")
vim.keymap.set('n', '<leader>N', "<cmd>Neotree float focus reveal<cr>")
vim.keymap.set('n', '<leader>f', "<cmd>FzfLua files<cr>")
vim.keymap.set('n', '<leader>b', "<cmd>FzfLua buffers<cr>")
vim.keymap.set('n', '<leader>s', "<cmd>FzfLua lsp_document_symbols<cr>")
vim.keymap.set('n', '<leader>S', "<cmd>FzfLua lsp_workspace_symbols<cr>")
vim.keymap.set('n', '<leader>l', "<cmd>FzfLua live_grep<cr>")
vim.keymap.set('n', '<leader>p', "<cmd>FzfLua commands<cr>")
vim.keymap.set('n', '<leader>c', "<cmd>FzfLua colorschemes<cr>")

--------------------------------------------------------------------------------
------------------------------------ Utils -------------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>w', "<C-W>", { noremap = false })
vim.keymap.set('n', '<leader>q', "<cmd>Bdelete<CR>")
vim.keymap.set('n', '<leader>Q', "<cmd>bdelete<CR>")
vim.keymap.set('n', '<leader>e', "<cmd>lua vim.diagnostic.open_float()<CR>")

--------------------------------------------------------------------------------
---------------------------------- Navigation ----------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', ']c', "<cmd>Gitsigns next_hunk<CR>")
vim.keymap.set('n', '[c', "<cmd>Gitsigns prev_hunk<CR>")
vim.keymap.set('n', ']b', "<cmd>bn<CR>")
vim.keymap.set('n', ']e', "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set('n', '[b', "<cmd>bp<CR>")
vim.keymap.set('n', '[e', "<cmd>lua vim.diagnostic.goto_prev()<CR>")

--------------------------------------------------------------------------------
------------------------------------- Git --------------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', 'gb', "<cmd>Gitsigns blame_line<CR>")
vim.keymap.set('n', 'grh', "<cmd>Gitsigns reset_hunk<CR>")
vim.keymap.set('n', 'grb', "<cmd>Gitsigns reset_buffer<CR>")

--------------------------------------------------------------------------------
---------------------------------- Completion -----------------------------------
--------------------------------------------------------------------------------
vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
vim.keymap.set('i', '<CR>', 'v:lua._Completion.cr_action()', { expr = true, replace_keycodes = false, })
vim.keymap.set('i', '<C-y>', 'v:lua._Completion.confirm_completion()',
    { expr = true, replace_keycodes = false, noremap = true })
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', {})
vim.keymap.set('i', '.', '.<C-x><C-o>', { noremap = true })
vim.keymap.set('i', '::', '::<C-x><C-o>', { noremap = true })
vim.keymap.set('i', '->', '::<C-x><C-o>', { noremap = true })
--------------------------------------------------------------------------------
--------------------------- Language Server Protocol ---------------------------
--------------------------------------------------------------------------------
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gi', "<cmd>FzfLua lsp_implementations<CR>")
vim.keymap.set('n', 'gi', "<cmd>FzfLua lsp_references<CR>")
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action)
vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help)
