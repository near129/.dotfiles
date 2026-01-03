vim.g.mapleader = ','

require('options') -- Load before lazy
require('plugins.lazy')
require('lsp')
require('mappings')
require('utils')
