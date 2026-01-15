return {
  {
    'oahlen/iceberg.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'iceberg',
        callback = function()
          local hl = vim.api.nvim_set_hl
          -- Increase brightness from default for better readability
          hl(0, 'NonText', { fg = '#4e598a' })
        end,
      })
      -- Note that the colorscheme must be set after the autocmd, otherwise the autocmd will not respond to the initial colorscheme change
      vim.cmd.colorscheme('iceberg')
    end,
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000, lazy = false },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      dashboard = {
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
        lualine_x = {
          {
            function()
              return require('copilot_status').status_string()
            end,
            cond = function()
              return require('copilot_status').enabled()
            end,
          },
          'encoding',
          'fileformat',
          'filetype',
        },
      },
    },
  },
  {
    'jonahgoldwastaken/copilot-status.nvim',
    dependencies = { 'zbirenbaum/copilot.lua' },
    event = { 'BufReadPost', 'BufNewFile' },
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
    config = true,
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
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      -- 'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },
}
