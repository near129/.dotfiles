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
}
