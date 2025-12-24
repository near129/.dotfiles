---@diagnostic disable: missing-parameter
return {
  { 'echasnovski/mini.jump', event = 'VeryLazy', config = true },
  { 'echasnovski/mini.trailspace', event = 'VeryLazy', config = true },
  { 'echasnovski/mini.pairs', event = 'VeryLazy', config = true },
  {
    'stevearc/conform.nvim',
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        markdown = { 'markdownlint-cli2' },
        javascript = { 'biome-check' },
        javascriptreact = { 'biome-check' },
        typescript = { 'biome-check' },
        typescriptreact = { 'biome-check' },
        python = {
          'ruff_fix',
          'ruff_format',
          'ruff_organize_imports',
        },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = 'fallback',
      },
    },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
        desc = 'Format',
      },
    },
  },
  {
    'smoka7/hop.nvim',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        '<space>',
        function()
          require('hop').hint_char1()
        end,
      },
    },
    config = true,
  },
  {
    'ojroques/nvim-osc52',
    evnet = { 'BufReadPost', 'BufNewFile' },
    config = true,
    keys = {
      {
        '<leader>c',
        function()
          require('osc52').copy_visual()
        end,
        mode = 'v',
      },
    },
  },
  {
    'vim-skk/skkeleton',
    lazy = false,
    dependencies = { 'vim-denops/denops.vim' },
    config = function()
      vim.fn['skkeleton#config']({
        -- https://skk-dev.github.io/dict/
        -- https://skk-dev.github.io/dict/SKK-JISYO.L.gz
        globalDictionaries = { '~/.local/share/skk/SKK-JISYO.L' },
      })
    end,
    keys = {
      {
        '<C-j>',
        '<Plug>(skkeleton-toggle)',
        mode = { 'i', 'c' },
        noremap = false,
      },
    },
  },
}
