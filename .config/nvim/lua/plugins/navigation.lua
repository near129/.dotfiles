return {
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
      { '<leader>fd', '<cmd>Telescope diagnostics<cr>' },
      { '<leader>ft', '<cmd>Telescope treesitter<cr>' },
      { '<leader>fs', '<cmd>Telescope lsp_workspace_symbols<cr>' },
      { 'gr', '<cmd>Telescope lsp_references<cr>' },
      { 'gd', '<cmd>Telescope lsp_definitions<cr>' },
      { 'gi', '<cmd>Telescope lsp_implementations<cr>' },
      { 'gt', '<cmd>Telescope lsp_type_definitions<cr>' },
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
          find_command = {
            'fd',
            '--type',
            'file',
            '--hidden',
            '--no-ignore',
            '--exclude',
            '.DS_Store',
            '--exclude',
            '.git',
            '--exclude',
            '.venv',
            '--exclude',
            '.ruff_cache/',
            '--exclude',
            '.mypy_cache/',
            '--exclude',
            '__pycache__',
            '--exclude',
            'node_modules',
            '--exclude',
            '.next',
          },
        },
      },
    },
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true,
      },
      delete_to_trash = true,
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    keys = {
      {
        '<leader>o',
        '<cmd>Oil<cr>',
        desc = 'Open Oil file manager',
      },
    },
  },
  {
    'nvim-mini/mini.files',
    version = false,
    config = true,
    keys = {
      {
        '<leader>mf',
        '<cmd>lua MiniFiles.open()<cr>',
        desc = 'Open MiniFiles file manager',
      },
    },
  },
  {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    branch = 'stable', -- Use stable branch for production
    config = true,
    keys = {
      {
        '<leader>fy',
        '<cmd>Fyler<cr>',
        desc = 'Open Fyler View',
      },
    },
  },
}
