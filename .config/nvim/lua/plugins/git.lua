return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
    keys = {
      {
        '<leader>gh',
        function()
          require('gitsigns').preview_hunk_inline()
        end,
        desc = 'Preview Hunk',
      },
    },
  },
  {
    'folke/snacks.nvim',
    ---@type snacks.Config
    keys = {
      {
        '<leader>lg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
    },
  },
  { 'f-person/git-blame.nvim', event = { 'BufNewFile', 'BufReadPost' }, config = true },
  {
    'esmuellert/codediff.nvim',
    cmd = 'CodeDiff',
    keys = {
      { '<leader>gd', '<cmd>CodeDiff<cr>', desc = 'CodeDiff (working tree)' },
      { '<leader>gH', '<cmd>CodeDiff history<cr>', desc = 'CodeDiff history' },
      { '<leader>gF', '<cmd>CodeDiff history %<cr>', desc = 'CodeDiff file history' },
    },
    config = function(_, opts)
      require('codediff').setup(opts)
      -- Debounced replacement for `auto_open_on_cursor`
      require('codediff_follow_cursor').setup()
    end,
    opts = {
      explorer = {
        view_mode = 'tree',
        -- Jump to the modified pane after <CR> on a file
        focus_on_select = true,
      },
    },
  },
}
