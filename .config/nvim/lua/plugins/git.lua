return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
  },
  { 'sindrets/diffview.nvim', cmd = 'DiffviewOpen', config = true },
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
