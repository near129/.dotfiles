return {
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
    lazy = false,
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      vim.api.nvim_create_user_command('LspInlayHintToggle', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = 'Toggle inlay_hint' })
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client:supports_method('textDocument/inlayHint') or client.server_capabilities.inlayHintProvider then
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
      automatic_enable = true,
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
          require('tiny-code-action').code_action({})
        end,
        desc = 'Code Action',
      },
    },
  },
  {
    'ray-x/lsp_signature.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
  },
  {
    'b0o/schemastore.nvim',
    event = 'LspAttach',
  },
}
