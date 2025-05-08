---@diagnostic disable: missing-fields
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
    opts = {
      suggestion = {
        auto_trigger = true,
      },
    },
  },
}
