return {
  {
    'cocopon/iceberg.vim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('iceberg')
      vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = '#4b5055' })
    end,
  },
  { 'echasnovski/mini.starter', config = true },
  { 'echasnovski/mini.tabline', config = true },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'iceberg_dark',
      },
      sections = {
        lualine_x = {
          {
            function()
              return require('copilot_status').status_string()
            end,
            cond = function()
              return require('copilot_status').enabled()
            end,
          },
        },
      },
    },
  },
  {
    'jonahgoldwastaken/copilot-status.nvim',
    dependencies = { 'zbirenbaum/copilot.lua' },
    event = 'BufReadPost',
    config = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    'norcalli/nvim-colorizer.lua',
    evnet = { 'BufReadPost', 'BufNewFile' },
    config = true,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
}
