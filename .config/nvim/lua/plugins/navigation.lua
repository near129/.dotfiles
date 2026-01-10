return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
      { '<leader>fhc', '<cmd>Telescope command_history<cr>' },
      { '<leader>fhs', '<cmd>Telescope search_history<cr>' },
      { '<leader>fk', '<cmd>Telescope keymaps<cr>' },
      { '<leader>fd', '<cmd>Telescope diagnostics<cr>' },
      { '<leader>ft', '<cmd>Telescope treesitter<cr>' },
      { '<leader>fs', '<cmd>Telescope lsp_workspace_symbols<cr>' },
      { '<leader>fc', '<cmd>Telescope git_bcommits<cr>' },
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
    keys = {
      {
        '<leader>o',
        '<cmd>Oil<cr>',
        desc = 'Open Oil file manager',
      },
    },
  },
  {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'nvim-mini/mini.icons', 'folke/snacks.nvim' },
    branch = 'stable', -- Use stable branch for production
    ---@module 'fyler'
    ---@type FylerSetup
    opts = {
      hooks = {
        on_rename = function(src_path, destination_path)
          require('snacks').rename.on_rename_file(src_path, destination_path)
        end,
      },
      views = {
        ---@diagnostic disable-next-line: missing-fields
        finder = {
          delete_to_trash = true,
        },
      },
    },
    keys = {
      {
        '<leader>fy',
        '<cmd>Fyler<cr>',
        desc = 'Open Fyler View',
      },
    },
  },
}
