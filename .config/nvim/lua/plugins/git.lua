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
}
