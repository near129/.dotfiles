return {
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
    ---@diagnostic disable-line: missing-fields
    opts = {
      filetypes = {
        markdown = true,
        yaml = true,
      },
      ---@diagnostic disable-next-line: missing-fields
      suggestion = {
        auto_trigger = true,
        ---@diagnostic disable-next-line: missing-fields
        keymap = {
          accept = '<C-l>',
          accept_word = '<C-;>',
        },
      },
    },
  },
}
