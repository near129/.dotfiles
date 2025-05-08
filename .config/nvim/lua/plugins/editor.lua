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
    config = function()
      require('hop').setup()
      vim.api.nvim_set_hl(0, 'HopNextKey', { fg = '#668e3d', bold = true })
      vim.api.nvim_set_hl(0, 'HopNextKey1', { fg = '#c57339', bold = true })
      vim.api.nvim_set_hl(0, 'HopNextKey2', { fg = '#c57339', bold = true })
    end,
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
  { 'nmac427/guess-indent.nvim', event = 'VeryLazy', config = true },
}
