---@diagnostic disable: missing-parameter
---@diagnostic disable: missing-fields
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
  { 'echasnovski/mini.jump', event = 'VeryLazy', config = true },
  { 'echasnovski/mini.trailspace', event = 'VeryLazy', config = true },
  { 'echasnovski/mini.pairs', event = 'VeryLazy', config = true },
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
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')
      configs.setup({
        auto_install = true,
      })
    end,
  },
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
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig',
    },
    config = function()
      vim.lsp.enable(require('mason-lspconfig').get_installed_servers())
      vim.api.nvim_create_user_command('LspInlayHintToggle', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = 'Toggle inlay_hint' })
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspAttach', { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client.supports_method('textDocument/inlayHint') or client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })
    end,
  },
  {
    'williamboman/mason-lspconfig',
    dependencies = { 'mason.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    ---@class MasonLspconfigSettings
    opts = {
      ensure_installed = {
        'lua_ls',
      },
      automatic_installation = false,
    },
  },
  {
    'rachartier/tiny-code-action.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    event = 'LspAttach',
    config = true,
    keys = {
      {
        '<leader>ca',
        function()
          require('tiny-code-action').code_action()
        end,
        desc = 'Code Action',
      },
    },
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    config = true,
  },
  {
    'ray-x/lsp_signature.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'super-tab' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    opts_extend = { 'sources.default' },
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    ---@module 'copilot'
    ---@type CopilotConfig
    opts = {
      suggestion = {
        auto_trigger = true,
      },
    },
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
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
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
      { '<leader>fch', '<cmd>Telescope command_history<cr>' },
      { '<leader>fsh', '<cmd>Telescope search_history<cr>' },
      { '<leader>fk', '<cmd>Telescope keymaps<cr>' },
      { '<leader>fs', '<cmd>Telescope lsp_workspace_symbols<cr>' },
      { '<leader>fd', '<cmd>Telescope diagnostics<cr>' },
      { '<leader>ft', '<cmd>Telescope treesitter<cr>' },
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
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          -- The above is the default
          '--trim',
          '--hidden',
          '--glob',
          '!**/.git/*',
        },
      },
      pickers = {
        find_files = {
          find_command = { 'fd', '--type', 'file', '--hidden', '--exclude', '.git' },
        },
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
  { 'sindrets/diffview.nvim', cmd = 'DiffviewOpen', config = true },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'norcalli/nvim-colorizer.lua',
    evnet = { 'BufReadPost', 'BufNewFile' },
    config = true,
  },
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    dependencies = {
      'folke/snacks.nvim',
    },
    keys = {
      {
        '<leader>-',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        '<leader>cw',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
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
