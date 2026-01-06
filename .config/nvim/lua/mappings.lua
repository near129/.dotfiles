-- vim.g.leader = " " -- define at init.lua

vim.keymap.set('i', 'jj', '<Esc>', { silent = true })
vim.keymap.set('i', '<C-d>', '<C-g>u<Del>', { silent = true })
vim.keymap.set({ 'i', 'c' }, '<C-p>', '<Up>')
vim.keymap.set({ 'i', 'c' }, '<C-n>', '<Down>')
vim.keymap.set({ 'i', 'c' }, '<C-b>', '<Left>')
vim.keymap.set({ 'i', 'c' }, '<C-f>', '<Right>')
vim.keymap.set({ 'i', 'c' }, '<C-a>', '<Home>')
vim.keymap.set({ 'i', 'c' }, '<C-e>', '<End>')
vim.keymap.set({ 'i', 'c' }, '<C-d>', '<Del>')

vim.keymap.set('n', '<ESC><ESC>', ':noh<CR>')
vim.keymap.set('n', '>', '>>')
vim.keymap.set('n', '<', '<<')

vim.keymap.set('n', '<leader>q', ':bd<CR>', { silent = true })
vim.keymap.set('n', '<leader>[', ':bprev<CR>', { silent = true })
vim.keymap.set('n', '<leader>]', ':bnext<CR>', { silent = true })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = 1 })
end)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = -1 })
end)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})
