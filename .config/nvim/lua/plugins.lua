return {
  {
    'cocopon/iceberg.vim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('iceberg')
    end,
  },
  { 'echasnovski/mini.starter', opts = {} },
  { 'echasnovski/mini.tabline', opts = {} },
  { 'echasnovski/mini.jump', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.trailspace', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.pairs', event = 'VeryLazy', opts = {} },
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
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'folke/neodev.nvim',
      'ckipp01/stylua-nvim',
      'mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('mason-lspconfig').setup_handlers({
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
          })
        end,
      })
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
        }
      })
      require('lspconfig').lua_ls.setup({
        commands = {
          Format = {
            function()
              require('stylua-nvim').format_file()
            end,
          },
        },
        settings = {
          Lua = {
            format = { enable = false },
          },
        },
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts = {},
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    opts = {},
  },
  {
    'ray-x/lsp_signature.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      { 'zbirenbaum/copilot.lua', cmd = 'Copilot', opts = {} },
      { 'zbirenbaum/copilot-cmp', opts = {} },
      'onsails/lspkind-nvim',
    },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      cmp.setup({
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = 'copilot', group_index = 2 },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'path' },
          { name = 'buffer' },
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            symbol_map = { Copilot = '' },
          }),
        },
      })
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    evnet = 'VeryLazy',
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = function(...)
              return require('telescope.actions').close(...)
            end,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
      },
    },
  },
  {
    'smoka7/hop.nvim',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
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
    opts = {},
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
  { 'nmac427/guess-indent.nvim', event = 'VeryLazy', opts = {} },
  { 'sindrets/diffview.nvim', cmd = 'DiffviewOpen', opts = {} },
}
