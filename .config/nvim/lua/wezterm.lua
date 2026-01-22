local direction2hjkl = {
  Left = 'h',
  Down = 'j',
  Up = 'k',
  Right = 'l',
}

--- Move Neovim window or WezTerm pane in the given direction.
---@param direction 'Left' | 'Down' | 'Up' | 'Right''
local function move_nvim_win_or_wezterm_pane(direction)
  local win = vim.api.nvim_get_current_win()
  vim.cmd.wincmd(direction2hjkl[direction])
  if win == vim.api.nvim_get_current_win() then
    vim.system({ 'wezterm', 'cli', 'activate-pane-direction', direction }, { text = true }, function(res)
      if res.code ~= 0 then
        vim.notify('Failed to move WezTerm pane: ' .. (res.stderr or ''), vim.log.levels.ERROR)
      end
    end)
  end
end

vim.keymap.set('n', '<C-w>h', function()
  move_nvim_win_or_wezterm_pane('Left')
end, { desc = 'Move to left Neovim window or WezTerm pane' })
vim.keymap.set('n', '<C-w>j', function()
  move_nvim_win_or_wezterm_pane('Down')
end, { desc = 'Move to down Neovim window or WezTerm pane' })
vim.keymap.set('n', '<C-w>k', function()
  move_nvim_win_or_wezterm_pane('Up')
end, { desc = 'Move to up Neovim window or WezTerm pane' })
vim.keymap.set('n', '<C-w>l', function()
  move_nvim_win_or_wezterm_pane('Right')
end, { desc = 'Move to right Neovim window or WezTerm pane' })
