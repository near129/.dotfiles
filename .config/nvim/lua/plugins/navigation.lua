return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
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
      { '<leader>fws', '<cmd>Telescope lsp_workspace_symbols<cr>' },
      { '<leader>fds', '<cmd>Telescope lsp_document_symbols<cr>' },
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
      },
      pickers = {
        live_grep = {
          glob_pattern = { '!**/.git/*' },
          additional_args = {
            '--trim',
            '--hidden',
          },
        },
        find_files = {
          find_command = { 'fd', '--type', 'f', '--color', 'never', '--hidden', '--exclude', '.git' },
        },
      },
    },
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('fzf')
    end,
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
