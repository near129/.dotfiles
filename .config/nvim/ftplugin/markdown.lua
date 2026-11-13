vim.keymap.set('n', '<leader>mo', function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then
    vim.notify('Buffer has no file', vim.log.levels.ERROR)
    return
  end
  vim.system({ 'mo', path }, {}, function(result)
    if result.code ~= 0 then
      vim.schedule(function()
        vim.notify('mo failed: ' .. result.stderr, vim.log.levels.ERROR)
      end)
    end
  end)
end, { buffer = true, desc = 'Open in mo' })
