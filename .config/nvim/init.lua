vim.g.mapleader = ','

require('options') -- Load before lazy
require('plugins.lazy')
require('lsp')
require('mappings')
require('commands')
require('utils')

if vim.env.WEZTERM_PANE ~= nil then
  require('wezterm')
end
