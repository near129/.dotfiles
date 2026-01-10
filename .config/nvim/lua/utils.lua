vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(event)
    -- oil.nvim の仮想バッファは無視する
    if event.file:match('^oil://') then
      return
    end
    local dir = vim.fs.dirname(event.file)
    local force = vim.v.cmdbang == 1
    if
      vim.fn.isdirectory(dir) == 0
      and (force or vim.fn.confirm('"' .. dir .. '" does not exist. Create?', '&Yes\n&No') == 1)
    then
      vim.fn.mkdir(vim.fn.iconv(dir, vim.opt.encoding:get(), vim.opt.termencoding:get()), 'p')
    end
  end,
  desc = 'Auto mkdir',
})
